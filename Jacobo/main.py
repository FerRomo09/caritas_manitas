# utilizar este comando en la terminal :  source venv/bin/activate
# reviar abajo el por qué
"""
Se modifican temporalmente las variables de entorno para que, cuando
invoques python desde la terminal, estés usando el intérprete de Python
que está dentro de tu ambiente virtual (venv/bin/python) y no el sistema
global o cualquier otro intérprete de Python que pueda estar en tu PATH.


"""

# importamos fastAPI
from fastapi import FastAPI, Response, status, HTTPException
from fastapi.params import Body
from pydantic import BaseModel
from typing import Optional, List
from random import randrange
import json
import datetime

import modelos as am


import pyodbc


# Parámetros de conexión
CONNECTION_STRING = (
    "DRIVER={ODBC Driver 18 for SQL Server};"
    "SERVER=10.14.255.87;"
    "DATABASE=DB_CARITAS;"
    "UID=SA;"
    "PWD=Shakira123.;"
    "TrustServerCertificate=yes"
)


def get_db_connection():
    conn = pyodbc.connect(CONNECTION_STRING)
    return conn


# creamos una instancia de FastAPI
app = FastAPI()


def modificar_clave(diccionario, vieja_clave, nueva_clave):
    return {clave if clave != vieja_clave else nueva_clave: valor for clave, valor in diccionario.items()}


@app.get("/ordenes/{ID_EMPLEADO}")
def llamar_ordenes(ID_EMPLEADO: int):
    try:
        with get_db_connection() as conn:
            conn = get_db_connection()
            cursor = conn.cursor()
            cursor.execute(
                "SELECT * FROM OPE_ORDENES WHERE ID_EMPLEADO = ?", (ID_EMPLEADO,))
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


@app.put("/reprogram_order/{orderID}")
def reprogram_order(orderID: int,  info_body: am.Reprogramacion):

    comentarios = info_body.comentarios

    try:
        with get_db_connection() as conn:
            print("hola")
            current_date = datetime.date.today()
            print("hola2")
            conn = get_db_connection()
            print("hola3")
            cursor = conn.cursor()

            print("hola4")
            print(current_date)
            print(type(current_date))

            current_date = current_date.strftime("%Y-%m-%d")

            print(type(current_date))

            cursor.execute("UPDATE OPE_ORDENES SET FECHA_VISITA = ?, COMENTARIOS_REPROGRAMACION = ? WHERE ID_ORDEN = ?",
                           (current_date, comentarios, orderID))
            conn.commit()

            print("hola5")

        cursor.close()
        conn.close()

        return {"message": "Reprogramacion confirmada"}

    except pyodbc.Error:
        raise HTTPException(
            status_code=503, detail="No se pudo establecer conexión con la base de datos.")

    except Exception as error_name:
        raise HTTPException(status_code=500, detail=str(error_name))


# esto es un "decorator"
"""
Un "decorator" (decorador) en Python es una herramienta poderosa que permite
modificar o extender el comportamiento de funciones o métodos sin tener que cambiar
su código fuente. Esencialmente, los decoradores son una forma muy Pythonic de usar
funciones (o clases) para envolver otra función o método. Esta envoltura permite
que se ejecute código adicional antes o después de la función o método envuelto,
permitiendo así añadir o modificar su comportamiento.
"""

if __name__ == "__main__":
    import uvicorn
    uvicorn.run("main:app", host="0.0.0.0", port=8087, reload=True)
