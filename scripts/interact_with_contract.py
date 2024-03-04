from brownie import FeeRequester, network, config
import time

def simulate_user_interaction():
    # Ensure you're on the right network
    if network.show_active() in ['development', 'ganache-local']:
        print("Deploying to a local network, make sure you've deployed the contract first!")
    else:
        fee_requester = FeeRequester[-1]  # Get the most recently deployed `FeeRequester`

    print("Requesting fee...")
    tx = fee_requester.requestFee({"from": get_account()})
    tx.wait(1)  # Wait 1 block for transaction confirmation

    # Waiting for the oracle to update the fee might take some time
    print("Waiting for the oracle to update the fee...")
    time.sleep(60)  # Adjust based on the expected response time of your oracle

    # Fetch the updated fee
    updated_fee = fee_requester.returnedFee()
    print(f"Updated Fee: {updated_fee}")

def get_account():
    return accounts.add(config["wallets"]["from_key"])

def main():
    simulate_user_interaction()
