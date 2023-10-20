from pydantic import BaseModel
import datetime
from decimal import Decimal

class LoginRequest(BaseModel):
    username: str
    password: str

class OrderConfirmation(BaseModel):
    newPagoTemp: int
    newPagoFin: int

class LoginResponse(BaseModel):
    id: int
    rol: int

class UserResponse(BaseModel):
    id: int
    a_paterno: str
    a_materno: str
    nombre: str
    fecha_nacimiento: datetime.date
    email: str
    telefono: Decimal
    id_genero: int
