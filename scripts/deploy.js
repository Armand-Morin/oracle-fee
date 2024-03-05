const hre = require("hardhat");

async function main() {
    await hre.run('compile');

    const FeeRequester = await hre.ethers.getContractFactory("FeeRequester");
    const feeRequester = await FeeRequester.deploy();
    await feeRequester.deployed();

    console.log("FeeRequester deployed to:", feeRequester.address);
    console.log("Deployment transaction hash:", feeRequester.deployTransaction.hash);

    // Wait for a few block confirmations
    await feeRequester.deployTransaction.wait(5);

    // Verify the contract on Etherscan
    try {
        await hre.run("verify:verify", {
            address: feeRequester.address,
            constructorArguments: [],
        });
    } catch (error) {
        console.error("Verification failed:", error);
    }

    // Send 1 LINK to the deployed contract
    const linkTokenAddress = "0x326C977E6efc84E512bB9C30f76E30c160eD06FB"; // LINK token address
    const signer = (await hre.ethers.getSigners())[0]; // Adjust if your signer is different
    const linkToken = await hre.ethers.getContractAt("IERC20", linkTokenAddress, signer);
    const transferTx = await linkToken.transfer(feeRequester.address, hre.ethers.utils.parseEther("1"));
    await transferTx.wait();

    console.log("Sent 1 LINK to:", feeRequester.address);
}

main()
    .then(() => process.exit(0))
    .catch((error) => {
        console.error(error);
        process.exit(1);
    });
