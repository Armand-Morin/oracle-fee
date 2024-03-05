require("@nomiclabs/hardhat-ethers");
require("dotenv").config();

const { INFURA_PROJECT_ID, PRIVATE_KEY } = process.env;

module.exports = {
  solidity: "0.8.7",
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
      accounts: [process.env.PRIVATE_KEY].filter(Boolean) 
    }
  }
};
