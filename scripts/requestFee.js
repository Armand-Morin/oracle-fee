const hre = require("hardhat");

async function main() {
  // sepolia
  // const contractAddress = "0x5a9652ff0493D6fFa37F56F8278a8F5F22A3B551"; // Replace with your contract's address
  // local
  // const contractAddress = "0x69779902fd1d93fFe220992d5f39c6b7B939BAA4"; // Replace with your contract's address
  // goerli
  const contractAddress = "0x0C9Cc7087EFc4960a047e831229203e21b125435"; // Replace with your contract's address

  const FeeRequester = await hre.ethers.getContractFactory("FeeRequester");
  const feeRequester = await FeeRequester.attach(contractAddress);

  // Set custom gas price and gas limit
  const gasPrice = hre.ethers.utils.parseUnits('75', 'gwei'); // Example: 50 Gwei
  const gasLimit = 1000000; // Example gas limit

  // Requesting the fee with custom gas settings
  const transaction = await feeRequester.requestFeeWithParameters(100, 5, 10, { 
      gasPrice: gasPrice,
      gasLimit: gasLimit
  });
  await transaction.wait();

  console.log("Fee request sent. Transaction Hash:", transaction.hash);
}

// npx hardhat run scripts/requestFee.js

main()
  .then(() => process.exit(0))
  .catch((error) => {
    console.error(error);
    process.exit(1);
  });
