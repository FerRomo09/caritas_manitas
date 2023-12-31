from pydantic import BaseModel
import datetime
from decimal import Decimal
from typing import Optional


class LoginRequest(BaseModel):
    username: str
    password: str


class LoginResponse(BaseModel):
    rol: int
    token: str

class UserResponse(BaseModel):
    id: int
    apellido: str
    nombre: str
    email: str
    telefono: str
    id_genero: int
    fecha_nacimiento: str
  

class Reprogramacion(BaseModel):
    comentarios : str

class Orden(BaseModel):
    ID_ORDEN: int
    ID_DONANTE: int
    ID_EMPLEADO: Optional[int]
    FECHA_COBRO: Optional[datetime.date]
    FECHA_PAGO: Optional[datetime.date]
    FECHA_VISITA: Optional[datetime.date]
    IMPORTE: Optional[float]
    ESTATUS_ORDEN_FINAL: Optional[int]
    ESTATUS_ORDEN_TEMPORAL: Optional[int]
    COMENTARIOS: Optional[str]
    ID_DIRECCION_COBRO: Optional[int]
    FECHA_CONFIRMACION: Optional[datetime.date]
    COMENTARIOS_CANCELACION: Optional[str]
    COMENTARIOS_REPROGRAMACION: Optional[str]
    FECHA_REPROGRAMACION: Optional[datetime.date]
    REPROGRAMACION_TELEFONISTA: Optional[int]
