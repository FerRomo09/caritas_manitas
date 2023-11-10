from fastapi import Depends, HTTPException, Header
import jwt
import datetime
import json

# Leer la clave secreta del archivo de configuración
with open("config.json", "r") as config_file:
    config = json.load(config_file)
    SECRET_KEY = config["secret_key"]

# Función para crear tokens JWT
# Esta función toma los datos del usuario y crea un token JWT
def create_jwt_token(data):
    payload = {
        "data": data,
        # El token expira después de 50 días
        "exp": datetime.datetime.utcnow() + datetime.timedelta(days=50),
    }
    # Codificar el payload con la clave secreta
    return jwt.encode(payload, SECRET_KEY, algorithm="HS256")

# Función para validar tokens
# Esta función toma un token y verifica si es válido y no ha expirado
def validate_token(token: str):
    try:
        # Decodificar el token con la clave secreta
        payload = jwt.decode(token, SECRET_KEY, algorithms=["HS256"])
        # Devolver los datos del usuario
        return payload["data"]
    except jwt.ExpiredSignatureError:
        # Si el token ha expirado, se lanza una excepción
        raise HTTPException(status_code=401, detail="Token has expired")
    except jwt.InvalidTokenError:
        # Si el token es inválido, se lanza una excepción
        raise HTTPException(status_code=401, detail="Invalid token")

# Función para obtener el usuario actual
# Esta función extrae el token del encabezado "Authorization" y lo valida
def get_current_user(authorization: str = Header(None)):
    if authorization is None:
        # Si el encabezado "Authorization" falta, se lanza una excepción
        raise HTTPException(status_code=401, detail="Authorization header is missing")

    # Extraer el token del encabezado "Bearer"
    try:
        scheme, token = authorization.split()
        if scheme.lower() != "bearer":
            # Si el esquema de autenticación no es "Bearer", se lanza una excepción
            raise HTTPException(status_code=401, detail="Invalid authentication scheme")
    except ValueError:
        # Si el formato del encabezado "Authorization" es inválido, se lanza una excepción
        raise HTTPException(status_code=401, detail="Invalid authorization header format")

    # Validar el token y devolver los datos del usuario
    return validate_token(token)