# Authors: Francisco Jervis, Jacobo Hirsch
import bcrypt

# Function to hash a password
# This function takes a plaintext password, generates a salt, and creates a hash of the password with that salt.
def hash_password(password):
    # Generate salt
    salt = bcrypt.gensalt()
    # Create a hash of the password with the salt
    hashed_password = bcrypt.hashpw(password.encode('utf-8'), salt)
    # Return the hashed password
    return (hashed_password)

# Function to verify a password
# This function takes a plaintext password and a hashed password, and verifies if the plaintext password,
# when hashed with the salt of the hashed password, results in the same hashed password.
def check_password(password, hashed_password):
    # Verify the password
    return bcrypt.checkpw(password.encode('utf-8'), hashed_password.encode('utf-8'))
    