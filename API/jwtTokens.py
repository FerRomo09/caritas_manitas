from fastapi import HTTPException, Header
import jwt
import datetime
import json

# Read the secret key from the configuration file
with open("config.json", "r") as config_file:
    config = json.load(config_file)
    SECRET_KEY = config["secret_key"]

# Function to create JWT tokens
# This function takes user data and creates a JWT token
def create_jwt_token(data):
    payload = {
        "data": data,
        # The token expires after 50 days
        "exp": datetime.datetime.utcnow() + datetime.timedelta(minutes=3),
    }
    # Encode the payload with the secret key
    return jwt.encode(payload, SECRET_KEY, algorithm="HS256")

# Function to validate tokens
# This function takes a token and verifies if it is valid and not expired
def validate_token(token: str):
    try:
        # Decode the token with the secret key
        payload = jwt.decode(token, SECRET_KEY, algorithms=["HS256"])
        # Return the user data
        return payload["data"]
    except jwt.ExpiredSignatureError:
        # If the token has expired, an exception is thrown
        raise HTTPException(status_code=401, detail="Token has expired")
    except jwt.InvalidTokenError:
        # If the token is invalid, an exception is thrown
        raise HTTPException(status_code=401, detail="Invalid token")

# Function to get the current user
# This function extracts the token from the "Authorization" header and validates it
def get_current_user(authorization: str = Header(None)):
    if authorization is None:
        # If the "Authorization" header is missing, an exception is thrown
        raise HTTPException(status_code=401, detail="Authorization header is missing")

    # Extract the token from the "Bearer" header
    try:
        scheme, token = authorization.split()
        if scheme.lower() != "bearer":
            # If the authentication scheme is not "Bearer", an exception is thrown
            raise HTTPException(status_code=401, detail="Invalid authentication scheme")
    except ValueError:
        # If the format of the "Authorization" header is invalid, an exception is thrown
        raise HTTPException(status_code=401, detail="Invalid authorization header format")

    # Validate the token and return the user data
    return validate_token(token)