const hre = require("hardhat");

async function main() {
  const contractAddress = "0x5a9652ff0493D6fFa37F56F8278a8F5F22A3B551"; // Replace with your contract's address
  const FeeRequester = await hre.ethers.getContractFactory("FeeRequester");
  const feeRequester = await FeeRequester.attach(contractAddress);

  // Requesting the fee
  const transaction = await feeRequester.requestFee();
  await transaction.wait();

  console.log("Fee request sent. Transaction Hash:", transaction.hash);

  // Assuming an event is emitted when the fee is updated
  // Listen for the event or query the updated fee after some time
  // This part is dependent on how your contract and oracle are set up
}

// npx hardhat run scripts/requestFee.js


main()
  .then(() => process.exit(0))
  .catch((error) => {
    console.error(error);
    process.exit(1);
  });
