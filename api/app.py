from flask import Flask, jsonify, request
from flask_cors import CORS
import numpy as np

app = Flask(__name__)
CORS(app)

@app.route('/compute-fee', methods=['GET'])
def compute_fee():
    # Extract query parameters with default value 0 if not provided
    amountUSD = request.args.get('amountUSD', default=0, type=float)
    price_diff = request.args.get('price_diff', default=0, type=float)
    std = request.args.get('std', default=0, type=float)

    # Apply sigmoid to each parameter and sum them
    fee = np.tanh(amountUSD) + np.tanh(price_diff) + np.tanh(std)

    # Return the inputs and the calculated fee
    return jsonify({
        "inputs": {
            "amountUSD": amountUSD,
            "price_diff": price_diff,
            "std": std
        },
        "fee": fee
    })

if __name__ == '__main__':
    app.run(debug=True, port=5000)
