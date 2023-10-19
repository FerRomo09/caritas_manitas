from fastapi import FastAPI, HTTPException
from typing import List
import pyodbc
import hashing as hs

# Define MSSQL database connection details
conn_str = (
    "DRIVER={ODBC Driver 18 for SQL Server};"
    "SERVER=10.14.255.87;" # Change to Team IP address assigned
    "DATABASE=DB_INGRESOS;" # Change to right DB 
    "UID=SA;"
    "PWD=Shakira123.;"
    "TrustServerCertificate=yes"  # Disable certificate validation
)

app = FastAPI()

# Function to establish a database connection
def get_db_connection():
    try:
        conn = pyodbc.connect(conn_str)
        return conn
    except Exception as e:
        return None

# Function to check login credentials
@app.post("/login")
def check_login(username: str, password: str):
    try:
        conn = get_db_connection()
        cursor = conn.cursor()

        cursor.execute("SELECT * FROM OPE_INGRESO WHERE USUARIO = ?", (username,))
        user = cursor.fetchone()

        cursor.close()
        conn.close()

        if user is None:
            raise HTTPException(status_code=404, detail="User not found")
        else:
            if hs.check_password(password, user[4]):
                return {"message": "Login successful"}
            else:
                raise HTTPException(status_code=403, detail="Incorrect password")
    except Exception as e:
        raise HTTPException(status_code=500, detail="Internal server error")

# Function to retrieve user data
@app.get("/user/{ID_Empleado}")
def get_user(ID_Empleado: str):
    try:
        user_data = get_user(ID_Empleado)
        if user_data is None:
            raise HTTPException(status_code=404, detail="User not found")
        return user_data
    except Exception as e:
        raise HTTPException(status_code=500, detail="Internal server error")

# Function to confirm an order was completed
@app.put("/confirm_order/{orderID}")
def confirm_order(orderID: int):
    try:
        if confirm_order(orderID):
            return {"message": "Order confirmed"}
        else:
            raise HTTPException(status_code=400, detail="Unable to confirm order")
    except Exception as e:
        raise HTTPException(status_code=500, detail="Internal server error")

if __name__ == "__main__":
    import uvicorn
    uvicorn.run(app, host="0.0.0.0", port=8000)
