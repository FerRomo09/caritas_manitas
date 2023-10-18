import pyodbc

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

def get_Donantes():
    try:
        conn = get_db_connection()
        cursor = conn.cursor()

        cursor.execute("SELECT * FROM OPE_DONANTES")
        users = [{'ID':row[0]}for row in cursor.fetchall()]

        cursor.close()
        conn.close()
        return users
    except Exception as e:
        return []
    
#Path: API/api_mssql.py