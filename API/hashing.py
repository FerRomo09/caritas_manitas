#Autores: Francisco Jervis, Jacobo Hirsch
import bcrypt

def hash_password(password):
    salt = bcrypt.gensalt()
    hashed_password = bcrypt.hashpw(password.encode('utf-8'), salt)
    return (hashed_password)

def check_password(password, hashed_password):
    return bcrypt.checkpw(password.encode('utf-8'), hashed_password.encode('utf-8'))

"""
if check_password("12345","$2b$12$1VFz1b8T2ZwnVNWkN/vhQeXoO87W75BVswWTHPV3MmB2zqOC4LlmW"):
    print("Password match")
else:
    print("Password does not match")
"""
