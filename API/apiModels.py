from pydantic import BaseModel

class LoginRequest(BaseModel):
    username: str
    password: str

class OrderConfirmation(BaseModel):
    newPagoTemp: int
    newPagoFin: int

class LoginResponse(BaseModel):
    message: str
    id: int
    rol: str

class UserResponse(BaseModel):
    id: int
    a_paterno: str
    a_materno: str
    nombre: str
    fecha_nacimiento: str
    email: str
    telefono: str
    id_genero: int
