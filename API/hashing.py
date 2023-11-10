#Autores: Francisco Jervis, Jacobo Hirsch
import bcrypt

# Función para hashear una contraseña
# Esta función toma una contraseña en texto plano, genera salt y crea un hash de la contraseña con esa salt.
def hash_password(password):
    # Generar salt
    salt = bcrypt.gensalt()
    # Crear un hash de la contraseña con la salt
    hashed_password = bcrypt.hashpw(password.encode('utf-8'), salt)
    # Devolver la contraseña hasheada
    return (hashed_password)

# Función para verificar una contraseña
# Esta función toma una contraseña en texto plano y una contraseña hasheada, y verifica si la contraseña en texto plano, 
# cuando se hashea con la sal de la contraseña hasheada, resulta en la misma contraseña hasheada.
def check_password(password, hashed_password):
    # Verificar la contraseña
    return bcrypt.checkpw(password.encode('utf-8'), hashed_password.encode('utf-8'))
