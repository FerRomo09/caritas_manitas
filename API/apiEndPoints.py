from fastapi import FastAPI, HTTPException, status
import pyodbc
import hashing as hs
import apiModels as am
import datetime


# from jwtTokens import create_jwt_token, get_current_user

app = FastAPI()

# Define MSSQL database connection details
conn_str = (
    "DRIVER={ODBC Driver 18 for SQL Server};"
    "SERVER=10.14.255.87;"  
    "DATABASE=DB_CARITAS;"  
    "UID=SA;"
    "PWD=Shakira123.;"
    "TrustServerCertificate=yes"  
    
)

# Function to establish a database connection
def get_db_connection():
    try:
        conn = pyodbc.connect(conn_str)
        return conn
    except Exception as e:
        return None

# Function to check login credentials
@app.post("/check_login", response_model= am.LoginResponse)
async def check_login(login_data: am.LoginRequest):
    username = login_data.username
    password = login_data.password

    try:
        conn = get_db_connection()
        cursor = conn.cursor()

        cursor.execute("SELECT O.*, E.ROL FROM DB_CARITAS.dbo.OPE_INGRESO AS O INNER JOIN DB_CARITAS.dbo.EMPLEADOS AS E ON O.ID_EMPLEADO = E.ID_EMPLEADO WHERE O.USUARIO = ?", (username,))
        user = cursor.fetchone()

        cursor.close()
        conn.close()
        if user is None:
            raise HTTPException(status_code=404, detail="User not found")
        else:
            if hs.check_password(password, user[3]):
                
                '''
                # Create JWT token
                user_data = {"id": user[0], "username": username} 
                token = create_jwt_token(user_data)
                return {"message": "Login successful", "token": token, "id": user[0], "rol": user[5]}
                '''
                return {"id": user[1], "rol": 1 if user[4] else 0}
            else:
                raise HTTPException(status_code=401, detail="Incorrect password")#usar status
            
    except HTTPException as e:
        raise e
    except Exception as e:
        print(e)
        raise HTTPException(status_code=500, detail="Internal Server Error")


# Function to retrieve user data
@app.get("/get_user/{ID_Empleado}", response_model= am.UserResponse)
async def get_user(ID_Empleado: str):
    try:
        conn = get_db_connection()
        cursor = conn.cursor()

        cursor.execute("SELECT * FROM EMPLEADOS WHERE ID_EMPLEADO = ?", (ID_Empleado,))
        user = cursor.fetchone()

        cursor.close()
        conn.close()

        if user is None:
            raise HTTPException(status_code=404, detail="User not found")
        else:
            return {
                'id': user[0],
                'a_paterno': user[1],
                'a_materno': user[2],
                'nombre': user[3],
                'fecha_nacimiento': user[4],
                'email': user[5],
                'telefono': user[6],
                'id_genero': user[7]
            }
    except HTTPException as e:
        raise e
    except Exception as e:
        print(e)
        raise HTTPException(status_code=500, detail="Internal Server Error")


# Function to confirm an order was completed
@app.put("/confirm_order/{orderID}")
async def confirm_order(orderID: int, order_data: am.OrderConfirmation):
    newPagoTemp = order_data.newPagoTemp
    newPagoFin = order_data.newPagoFin
    try:
        conn = get_db_connection()
        cursor = conn.cursor()
        # ESTATUS_ORDEN_FINAL=0 1 2 ESTATUS_ORDEN_TEMPORAL=0 1 2
        cursor.execute("UPDATE OPE_ORDENES SET ESTATUS_ORDEN_TEMPORAL = ?, ESTATUS_ORDEN_FINAL = ? WHERE ID_ORDEN = ?", (newPagoTemp, newPagoFin, orderID,))
        conn.commit()
        if cursor.rowcount == 0:
            # No rows were affected, meaning the order with the specified ID does not exist
            raise HTTPException(status_code=404, detail="Order not found")
        cursor.close()
        conn.close()

        return {"message": "Order confirmed"}
    
    except HTTPException as e:
        raise e
    except Exception as e:
        print(e)
        raise HTTPException(status_code=500, detail="Internal Server Error")
    
    
    
    

#funcion para modificar unas de las llaves del diccionario  
def modificar_clave(diccionario, vieja_clave, nueva_clave):
    return {clave if clave != vieja_clave else nueva_clave: valor for clave, valor in diccionario.items()}



#endpoint que regresa en formato json las ordenes filtradas por el id del empleado  
@app.get("/ordenes/{ID_EMPLEADO}")
def llamar_ordenes(ID_EMPLEADO: int):
    try:
        with get_db_connection() as conn:
            conn = get_db_connection()
            cursor = conn.cursor()
            cursor.execute(
                "EXEC SelectOrderById @EmpleadoID = ?;", (ID_EMPLEADO,))
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




