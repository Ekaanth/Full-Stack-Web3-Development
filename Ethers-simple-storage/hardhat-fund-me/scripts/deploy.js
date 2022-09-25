const { ethers, run, network } = require("hardhat")
require("dotenv").config()

async function main() {
    const FundMeFactory = await ethers.getContractFactory("FundMe")
    console.log("Deploying the contact...")
    const fundMe = await FundMeFactory.deploy()
    await fundMe.deployed()
}

// We recommend this pattern to be able to use async/await everywhere
// and properly handle errors.
main()
    .then(() => process.exit(0))
    .catch((error) => {
        console.log(error)
        process.exit(0)
    })
