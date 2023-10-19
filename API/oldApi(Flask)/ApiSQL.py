from flask import Flask, request, jsonify
import sqlFunc as mssql

app = Flask(__name__)

# Retrieve all users from the database
@app.route('/testD', methods=['GET'])
def get_users():
    users = mssql.get_Donantes()
    return jsonify(users), 200

if __name__ == '__main__':
    app.run(debug=True, port=8088, host='0.0.0.0')