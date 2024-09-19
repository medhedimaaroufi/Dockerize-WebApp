from flask import Flask, jsonify
from flask_cors import CORS

app = Flask(__name__)

CORS(app)

@app.route("/")
def hello():
    #json = {"message": "Hello World"}
    return jsonify({"message": "Hello backend"}), 200


if __name__ == "__main__":
    app.run(debug=True)