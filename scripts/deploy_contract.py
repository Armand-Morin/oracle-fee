from brownie import FeeRequester, accounts, network, config, interface


def main():
    account = accounts.add(config["wallets"]["from_key"])
    
    # Deploy the FeeRequester contract
    fee_requester = FeeRequester.deploy({"from": account})
    print(f"Contract deployed to {fee_requester.address}")
    
    # Send LINK to the deployed contract
    link_token_address = config["networks"][network.show_active()]["link_token"]
    link_token = interface.LinkTokenInterface(link_token_address)
    send_amount = 0.1 * 10 ** 18  # Adjust the amount based on your requirement (0.1 LINK here)
    link_token.transfer(fee_requester.address, send_amount, {"from": account})
    print(f"Sent {send_amount} LINK to {fee_requester.address}")
