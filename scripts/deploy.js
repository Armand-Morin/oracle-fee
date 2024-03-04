const hre = require("hardhat");

async function main() {
  await hre.run('compile');

  // Deploy the contract
  const FeeRequester = await hre.ethers.getContractFactory("FeeRequester");
  const oracleAddress = "0x6090149792dAAeE9D1D568c9f9a6F6B46AA29eFD";
  const jobId = "ca98366cc7314957b8c012c72f05aeeb";
  const fee = hre.ethers.utils.parseEther("0.1"); // Adjust based on the oracle fee
  const linkTokenAddress = "0x779877A7B0D9E8603169DdbD7836e478b4624789"; // LINK token address on the respective network

  const feeRequester = await FeeRequester.deploy(oracleAddress, jobId, fee, linkTokenAddress);

  await feeRequester.deployed();

  console.log("FeeRequester deployed to:", feeRequester.address);
}

// npx hardhat run scripts/deploy.js --network goerli


main()
  .then(() => process.exit(0))
  .catch((error) => {
    console.error(error);
    process.exit(1);
  });
