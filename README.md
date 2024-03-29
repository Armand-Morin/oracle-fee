# Project Title

## Description

This project demonstrates the deployment and interaction with a smart contract on Ethereum. The `FeeRequester` contract allows users to request and calculate fees based on certain input parameters. The project utilizes Hardhat for compilation, testing, deployment, and verification of the smart contract on Ethereum networks such as Goerli or Sepolia testnets.

## Prerequisites

Before you begin, ensure you have [Node.js](https://nodejs.org/) and [Yarn](https://classic.yarnpkg.com/en/docs/install) installed on your machine. You will also need an Ethereum wallet with testnet ETH for deployment and interaction with the contract on a testnet.

## Setting Up

1. Clone the repository:
    ```sh
    git clone <repository-url>
    cd <repository-directory>
    ```

2. Install dependencies:
    ```sh
    yarn install
    ```

3. Create a `.env` file in the root directory of the project and add the following environment variables:
    ```plaintext
    INFURA_PROJECT_ID=<your-infura-project-id>
    PRIVATE_KEY=<your-wallet-private-key>
    ETHERSCAN_API_KEY=<your-etherscan-api-key>
    ```

    Replace the placeholders with your actual Infura project ID, wallet's private key, and Etherscan API key.

## Deploying the Contract

To deploy the `FeeRequester` contract to a network, use the following command, replacing `<networkName>` with the name of the network (e.g., `goerli`, `sepolia`):

```sh
npx hardhat run scripts/deploy.js --network <networkName>
```
This command will:
-  compile the contract
-  deploy the contrqct on the network selected
-  verify the contract with the code and the abi
-  send 1 LINK to the contract to use the ChainLink Oracle

## Verifying the Contract on Etherscan
After deploying, verify the contract on Etherscan by using the following command. Replace <networkName> with the network you deployed to, and <contractAddress> with the address of the deployed contract:

```sh
npx hardhat verify --network <networkName> <contractAddress>
```

## Interacting with the Deployed Contract
Run the following command to interact with the deployed contract using a predefined script:

```sh
npx hardhat run scripts/requestFee.js --network <networkName>
```

Exposing Local Development Server with ngrok
To expose your local Flask API for the smart contract to interact with, follow these steps:

- Ensure your Flask API is running locally on port 5000.
- Download and install ngrok.
- Start ngrok to forward requests to your local server:
```sh
ngrok http http://127.0.0.1:5000
```
- Copy the forwarding URL provided by ngrok (e.g., https://<unique-id>.ngrok.io) and use it in your smart contract or API request script.
- To test if your setup works, you can visit the ngrok URL in your browser or use a tool like curl:
```sh
https://<unique-id>.ngrok-free.app/compute-fee?amountUSD=1&price_diff=1&std=1
```

## Additional Commands
Compiling Contracts:
Compile your contracts using:

```sh
npx hardhat compile
```

## Running Tests:
Execute tests to ensure your contracts behave as expected:

```sh
npx hardhat test
```

## Hardhat Local Network:
To interact with your contracts on a local Hardhat network, start the network using:

```sh
npx hardhat node
```
Then, deploy and interact with your contracts as described above, using --network hardhat.

## Contributing
Contributions are welcome! Please open an issue or submit a pull request with any improvements, fixes, or additional features.

## License
This project is licensed under the MIT License - see the LICENSE file for details.
