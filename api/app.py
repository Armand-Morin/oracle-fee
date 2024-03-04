from flask import Flask, jsonify

app = Flask(__name__)

@app.route('/compute-fee', methods=['GET'])
def compute_fee():
    # Return a fixed fee for simplicity
    return jsonify({"fee": 100})

if __name__ == '__main__':
    app.run(debug=True, port=5000)
