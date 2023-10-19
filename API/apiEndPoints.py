from fastapi import FastAPI, HTTPException
import pyodbc
import hashing as hs
import apiModels as am

app = FastAPI()

# Define MSSQL database connection details
conn_str = (
    "DRIVER={ODBC Driver 18 for SQL Server};"
    "SERVER=10.14.255.87;"  
    "DATABASE=DB_INGRESOS;"  
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

        cursor.execute("SELECT * FROM OPE_INGRESO WHERE USUARIO = ?", (username,))
        user = cursor.fetchone()

        cursor.close()
        conn.close()

        if user is None:
            raise HTTPException(status_code=401, detail="User not found")
        else:
            if hs.check_password(password, user[4]):
                return {"message": "Login successful", "id": user[0], "rol": user[5]}
            else:
                raise HTTPException(status_code=401, detail="Incorrect password")
    except Exception as e:
        raise HTTPException(status_code=500, detail="Internal Server Error")


# Function to retrieve user data
@app.get("/get_user/{ID_Empleado}", response_model= am.UserResponse)
async def get_user(ID_Empleado: str):
    try:
        conn = get_db_connection()
        cursor = conn.cursor()

        cursor.execute("SELECT * FROM OPE_EMPLEADO WHERE USUARIO = ?", (ID_Empleado,))
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
    except Exception as e:
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
        cursor.execute("UPDATE OPE_ORDENES SET ESTATUS_PAGO_TEMPORAL = ?, ESTATUS_PAGO_FINAL = ? WHERE ID_ORDEN = ?", (newPagoTemp, newPagoFin, orderID,))
        conn.commit()

        cursor.close()
        conn.close()

        return {"message": "Order confirmed"}
    except Exception as e:
        raise HTTPException(status_code=500, detail="Internal Server Error")


if __name__ == "__main__":
    import uvicorn
    uvicorn.run(app, host="0.0.0.0", port=8037)
