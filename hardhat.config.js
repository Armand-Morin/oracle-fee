require("@nomiclabs/hardhat-waffle");

module.exports = {
  solidity: "0.8.7",
  networks: {
    goerli: {
      url: "https://goerli.infura.io/v3/YOUR_INFURA_PROJECT_ID",
      accounts: [`0x${process.env.PRIVATE_KEY}`]
    }
  }
};
