from brownie import FeeRequester, accounts, network, config, interface

def main():
    deploy_and_fund_fee_requester()

def deploy_and_fund_fee_requester():
    account = accounts.add(config["wallets"]["from_key"])

    # Sepolia Testnet example addresses and job ID; replace these with actual values for your target network
    oracle_address = "0x6090149792dAAeE9D1D568c9f9a6F6B46AA29eFD"  # Example Oracle address
    job_id = "ca98366cc7314957b8c012c72f05aeeb"  # Example Job ID (convert to bytes32 if necessary)
    link_token_address = config["networks"][network.show_active()]["link_token"]  # LINK token address from config
    fee = 0.1 * 10 ** 18  # Example fee (0.1 LINK)

    # Deploy the FeeRequester contract
    fee_requester = FeeRequester.deploy(
        oracle_address, 
        bytes.fromhex(job_id.replace("0x", "")),  # Convert job_id string to bytes32
        fee, 
        link_token_address,
        {"from": account}
    )
    print(f"Contract deployed to {fee_requester.address}")

    # Send LINK to the deployed contract for Chainlink requests
    send_link_to_contract(fee_requester.address, account, link_token_address, fee)

def send_link_to_contract(contract_address, account, link_token_address, amount):
    link_token = interface.LinkTokenInterface(link_token_address)
    tx = link_token.transfer(contract_address, amount, {"from": account})
    tx.wait(1)  # Wait for the transaction to be confirmed
    print(f"Sent {amount / 10**18} LINK to {contract_address}")

