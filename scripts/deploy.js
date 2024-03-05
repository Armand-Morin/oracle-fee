const hre = require("hardhat");

async function main() {
    await hre.run('compile');

    const FeeRequester = await hre.ethers.getContractFactory("FeeRequester");
    const feeRequester = await FeeRequester.deploy();

    await feeRequester.deployed();

    console.log("FeeRequester deployed to:", feeRequester.address);
    // Print the transaction hash
    console.log("Deployment transaction hash:", feeRequester.deployTransaction.hash);
}

main()
    .then(() => process.exit(0))
    .catch((error) => {
        console.error(error);
        process.exit(1);
    });
