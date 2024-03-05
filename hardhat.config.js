require("@nomiclabs/hardhat-ethers");
require("@nomiclabs/hardhat-etherscan");

require("dotenv").config();

const { INFURA_PROJECT_ID, PRIVATE_KEY, ETHERSCAN_API_KEY } = process.env;

module.exports = {
  solidity: "0.8.7",

  etherscan: {
    apiKey: {
      sepolia: ETHERSCAN_API_KEY,
    },
  },

  networks: {
    goerli: {
      url: `https://goerli.infura.io/v3/${INFURA_PROJECT_ID}`,
      accounts: [PRIVATE_KEY].filter(Boolean)
    },
    mumbai: {
      url: "https://polygon-mumbai-bor-rpc.publicnode.com",
      accounts: [PRIVATE_KEY].filter(Boolean)
    },
    sepolia: {
      url: `https://sepolia.infura.io/v3/${INFURA_PROJECT_ID}`, 
      accounts: [process.env.PRIVATE_KEY].filter(Boolean) 
    },
    ganache: {
      url: "HTTP://127.0.0.1:7545", // Or whatever your Ganache RPC server address is
      accounts: ["0x4bf4707f9ef0c8c54c493a6985d3aa07e0cc598f6388d9c2ead648af24d84908"].filter(Boolean) 
    }
  }
};
