require("@nomiclabs/hardhat-waffle"); // If you're using Waffle for testing
require("@nomiclabs/hardhat-ethers");

module.exports = {
  solidity: "0.8.7",
  networks: {
    goerli: {
      url: `https://goerli.infura.io/v3/${process.env.WEB3_INFURA_PROJECT_ID}`,
      accounts: [process.env.PRIVATE_KEY].filter(Boolean)
    }
  }
};
