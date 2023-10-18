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

# Function to establish a database connection
def get_db_connection():
    try:
        conn = pyodbc.connect(conn_str)
        return conn
    except Exception as e:
        return None
    
# Function to check login credentials
def check_login(username, password):
    try:
        conn = get_db_connection()
        cursor = conn.cursor()

        cursor.execute("SELECT * FROM OPE_INGRESO WHERE USUARIO = ?", (username,))
        user = cursor.fetchone()

        cursor.close()
        conn.close()

        if user is None:
            return False
        else:
            return hs.check_password(password, user[4])
    except Exception as e:
        return False
    
# Function to retrieve user data
def get_user(ID_Empleado):
    try:
        conn = get_db_connection()
        cursor = conn.cursor()

        cursor.execute("SELECT * FROM OPE_EMPLEADO WHERE USUARIO = ?", (ID_Empleado,))
        user = cursor.fetchone()

        cursor.close()
        conn.close()

        if user is None:
            return None
        else:
            return {
                'id': user[0],
                'a_paterno': user[1],
                'a_materno': user[2],
                'nombre': user[3],
                'fecha_nacimiento': user[4],
                'email': user[5],
                'telefono': user[6],
                'id_genero': user[7],
                'rol': user[8]
            }
    except Exception as e:
        return None
    
# Function to confirm an order was completed
def confirm_order(orderID):
    try:
        conn = get_db_connection()
        cursor = conn.cursor()
        #ESTATUS_ORDEN_FINAL=0 1 2 ESTATUS_ORDEN_TEMPORAL=0 1 2 
        cursor.execute("UPDATE OPE_ORDENES SET ESTATUS_PAGO_TEMPORAL = ?, ESTATUS_PAGO_FINAL = ? WHERE ID_ORDEN = ?", (orderID,))
        conn.commit()

        cursor.close()
        conn.close()

        return True
    except Exception as e:
        return False





def get_Donantes():
    try:
        conn = get_db_connection()
        cursor = conn.cursor()

        cursor.execute("SELECT * FROM OPE_DONANTES")
        users = [{'ID':row[0],'NOMBRE':row[3]}for row in cursor.fetchall()]

        cursor.close()
        conn.close()
        return users
    except Exception as e:
        return []
"""

# Create a user in the database
def create_user(userid, username, email,passwd):
    try:
        conn = get_db_connection()
        cursor = conn.cursor()

        cursor.execute(" INSERT INTO users (UserID, username, email, PasswordHash) VALUES (?, ?, ?, HASHBYTES('SHA2_256',?))", (userid, username, email, passwd))
        conn.commit()

        cursor.close()
        conn.close()

        return True
    except Exception as e:
        return False

# Retrieve all users from the database
def get_users():
    try:
        conn = get_db_connection()
        cursor = conn.cursor()

        cursor.execute("SELECT UserID, username, email FROM users")
        users = [{'ID': row[0], 'User': row[1], 'email': row[2]} for row in cursor.fetchall()]

        cursor.close()
        conn.close()

        return users
    except Exception as e:
        return []

# Update a user in the database
def update_user(userID, username, email, passwd):
    try:
        conn = get_db_connection()
        cursor = conn.cursor()

        cursor.execute("UPDATE users SET username = ?, email = ?, PasswordHash = HASHBYTES('SHA2_256',?) WHERE UserID = ?", (username, email, passwd, userID))
        conn.commit()

        cursor.close()
        conn.close()

        return True
    except Exception as e:
        return False
    


# Delete a user from the database
def delete_user(userID):
    try:
        conn = get_db_connection()
        cursor = conn.cursor()

        cursor.execute("DELETE FROM users WHERE UserID = ?", (userID,))
        conn.commit()

        cursor.close()
        conn.close()

        return True
    except Exception as e:
        return False

    
"""
#Path: API/api_mssql.py