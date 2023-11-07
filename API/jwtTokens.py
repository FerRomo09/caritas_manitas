from fastapi import Depends, HTTPException
import jwt
import datetime
import json


# Read the secret key from the configuration file
with open("config.json", "r") as config_file:
    config = json.load(config_file)
    SECRET_KEY = config["secret_key"]


# Function to create JWT tokens
def create_jwt_token(data):
    payload = {
        "data": data,
        "exp": datetime.datetime.utcnow() + datetime.timedelta(hours=1)
    }
    return jwt.encode(payload, SECRET_KEY, algorithm="HS256")

# Function to validate tokens
def validate_token(token: str):
    try:
        payload = jwt.decode(token, SECRET_KEY, algorithms=["HS256"])
        return payload["data"]
    except jwt.ExpiredSignatureError:
        raise HTTPException(status_code=401, detail="Token has expired")
    except jwt.InvalidTokenError:
        raise HTTPException(status_code=401, detail="Invalid token")

# Function to get current user
def get_current_user(token: str = Depends(validate_token)):
    return token

'''
# Protected endpoint
@app.get("/protected_endpoint")
async def protected_endpoint(current_user: dict = Depends(get_current_user)):
    return {"message": "This is a protected endpoint", "user": current_user}

decoradores**

'''