from flask import Flask, jsonify
from flask_cors import CORS

app = Flask(__name__)
CORS(app)

@app.route('/compute-fee', methods=['GET'])
def compute_fee():
    # Return a fixed fee for simplicity
    return jsonify({"fee": 100})

if __name__ == '__main__':
    app.run(debug=True, port=5000)
