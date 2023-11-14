from fastapi import FastAPI, HTTPException, status, Depends, Header
import pyodbc
import hashing as hs
import apiModels as am
import datetime
import json
from jwtTokens import create_jwt_token, get_current_user

app = FastAPI()

# Read the config file
with open("config.json", "r") as config_file:
    config = json.load(config_file)
    SERVER = str(config["SERVER"])
    DATABASE = str(config["DATABASE"])
    UID = str(config["UID"])
    PWD = str(config["PWD"])
    DRIVER = str(config["DRIVER"])

# Define MSSQL database connection details
conn_str = (
    "DRIVER={};"
    "SERVER={};"
    "DATABASE={};"
    "UID={};"
    "PWD={};"
    "TrustServerCertificate=yes").format(DRIVER, SERVER, DATABASE, UID, PWD)

# Function to establish a database connection


def get_db_connection():
    try:
        conn = pyodbc.connect(conn_str)
        return conn
    except Exception as e:
        print(e)
        return None

# Function to verify login credentials
# This function takes the login data provided by the user
# and verifies if the user exists in the database and if the provided password is correct.


@app.post("/check_login", response_model=am.LoginResponse)
async def check_login(login_data: am.LoginRequest):
    username = login_data.username
    password = login_data.password

    try:
        # Establish connection with the database
        conn = get_db_connection()
        cursor = conn.cursor()

        # Execute stored procedure to get user details
        cursor.execute("EXEC GetIngresoDetails @Usuario = ?", (username,))
        user = cursor.fetchone()

        cursor.close()
        conn.close()
        if user is None:
            # If the user does not exist, an exception is thrown
            raise HTTPException(status_code=500)
        else:
            # If the user exists, the password is verified
            if hs.check_password(password, user[3]):

                # If the password is correct, a JWT token is created
                user_data = {"id": str(user[1]), "username": username}
                token = create_jwt_token(user_data)

                # The user's role and token are returned
                return {"rol": user[4], "token": token}
            else:
                # If the password is incorrect, an exception is thrown
                raise HTTPException(status_code=500)
    except Exception as e:
        print(e)
        raise HTTPException(status_code=500, detail="Internal server error")

# Function to retrieve user data
# This function takes the user ID and returns the user details from the database.


@app.get("/get_user", response_model=am.UserResponse)
async def get_user(current_user: dict = Depends(get_current_user)):
    ID_Empleado = current_user["id"]
    try:
        # Establish connection with the database
        conn = get_db_connection()
        cursor = conn.cursor()

        # Execute stored procedure to get user details
        cursor.execute(
            "EXEC GetEmpleadoDetails @ID_EMPLEADO = ?", (ID_Empleado,))
        user = cursor.fetchone()

        cursor.close()
        conn.close()

        if user is None:
            # If the user does not exist, an exception is thrown
            raise HTTPException(status_code=404, detail="User not found")
        else:
            # If the user exists, the user details are returned
            return {
                'apellido': user[1] + " " + user[2],
                'nombre': user[3],
                'email': user[5],
                'telefono': str(user[6]),
                'id_genero': int(user[7]),
                'fecha_nacimiento': str(user[4])
            }
    except HTTPException as e:
        raise e
    except Exception as e:
        print(e)
        raise HTTPException(status_code=500, detail="Internal server error")

# Function to confirm that an order was completed
# This function takes the ID of an order and updates its status to "completed" in the database.


@app.put("/confirm_order/{orderID}")
async def confirm_order(orderID: int, current_user: dict = Depends(get_current_user)):
    try:
        # Establish connection with the database
        conn = get_db_connection()
        cursor = conn.cursor()

    # EstatusOrden = 1 is the status of completed order
    # EstatusOrden = 2 is the status of uncompleted order
    # EstatusOrden = 0 is the status of pending order

        # Execute stored procedure to update the order status
        cursor.execute(
            "EXEC UpdateOrdenEstatus @EstatusOrden = 1, @ID_ORDEN = ?; ", (orderID,))
        conn.commit()
        if cursor.rowcount == 0:
            # If the order does not exist, an exception is thrown
            raise HTTPException(status_code=404, detail="Order not found")
        cursor.close()
        conn.close()

        # If the order exists and is updated correctly, a confirmation message is returned
        return {"message": "Order confirmed"}

    except HTTPException as e:
        raise e
    except Exception as e:
        print(e)
        raise HTTPException(status_code=500, detail="Internal server error")

# funcion para modificar unas de las llaves del diccionario


def modificar_clave(diccionario, vieja_clave, nueva_clave):
    return {clave if clave != vieja_clave else nueva_clave: valor for clave, valor in diccionario.items()}


# endpoint que regresa en formato json las ordenes filtradas por el id del empleado
@app.get("/ordenes/{ID_EMPLEADO}/{ESTATUS_ORDEN}")
def llamar_ordenes(ID_EMPLEADO: int, ESTATUS_ORDEN: int):
    try:
        with get_db_connection() as conn:
            conn = get_db_connection()
            cursor = conn.cursor()
            cursor.execute(
                "EXEC SelectOrderById @EmpleadoID = ? , @EstatusOrden = ? ,;", (ID_EMPLEADO, ESTATUS_ORDEN,))
            resultados = cursor.fetchall()
            if len(resultados) != 0:
                ordenes_list = []
                for item in resultados:

                    data = {column[0]: value for column,
                            value in zip(cursor.description, item)}

                    # model_instance = am.Orden(**data)

                    data = modificar_clave(data, 'ID_ORDEN', 'id')

                    ordenes_list.append(data)

                    # print(type(model_instance))

            else:
                raise HTTPException(status_code=status.HTTP_404_NOT_FOUND,
                                    detail=f"orders with id: {ID_EMPLEADO} does not exists")

            cursor.close()
            conn.close()

        return {"mensaje": "ordenes llamadas exitosamenteeee", "list:": ordenes_list}

    # Asumiendo que DatabaseConnectionError es una excepción que podría lanzar get_db_connection().
    except pyodbc.Error:
        raise HTTPException(
            status_code=503, detail="No se pudo establecer conexión con la base de datos.")

    except Exception as error_name:
        raise HTTPException(status_code=500, detail=str(error_name))


# Endpoint para cambiar la informacion de las ordenes reprogramadas
@app.put("/reprogram_order/{orderID}")
def reprogram_order(orderID: int,  info_body: am.Reprogramacion):

    comentarios = info_body.comentarios

    try:
        with get_db_connection() as conn:

            current_date = datetime.date.today()
            current_date = current_date.strftime("%Y-%m-%d")
            conn = get_db_connection()
            cursor = conn.cursor()

            cursor.execute("UPDATE OPE_ORDENES SET FECHA_VISITA = ?, COMENTARIOS_REPROGRAMACION = ? WHERE ID_ORDEN = ?",
                           (current_date, comentarios, orderID))
            conn.commit()

        cursor.close()
        conn.close()

        return {"message": "Reprogramacion confirmada"}

    except pyodbc.Error:
        raise HTTPException(
            status_code=503, detail="No se pudo establecer conexión con la base de datos.")

    except Exception as error_name:
        raise HTTPException(status_code=500, detail=str(error_name))


if __name__ == "__main__":
    import uvicorn
    uvicorn.run("apiEndPoints:app", host="0.0.0.0", port=8037, reload=True)
