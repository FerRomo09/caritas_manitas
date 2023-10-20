from fastapi import FastAPI, HTTPException, status
import pyodbc
import hashing as hs
import apiModels as am

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


if __name__ == "__main__":
    import uvicorn
    uvicorn.run("apiEndPoints:app", host="0.0.0.0", port=8037, reload=True)
