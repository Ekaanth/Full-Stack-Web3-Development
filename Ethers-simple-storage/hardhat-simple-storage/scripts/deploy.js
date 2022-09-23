const { ethers, run, network } = require("hardhat")
require("dotenv").config()

async function main() {
    const SimpleStorageFactory = await ethers.getContractFactory(
        "SimpleStorage"
    )
    console.log("deploying contract ...")

    const simpleStorage = await SimpleStorageFactory.deploy()
    await simpleStorage.deployed()
    // console.log(`Deployed contract to: ${JSON.stringify(simpleStorage)}`)
    // console.log(`Network ID: ${network.config}`)
    if (network.config.chainId === 5 && process.env.ETHERSCAN_API_KEY) {
        await simpleStorage.deployTransaction.wait(6)
        console.log("Waiting for block verification....")
        await verify(simpleStorage.address, [])
    }

    const currentValue = await simpleStorage.retrieve()
    console.log(`Current value is: ${currentValue}`)

    const transactionResponse = await simpleStorage.store(7)
    await transactionResponse.wait(1)
    const updatedValue = await simpleStorage.retrieve()
    console.log(`Updated Value is : ${updatedValue}`)
}

async function verify(contractAddress, args) {
    console.log("Verifying contract....")
    try {
        await run("verify:verify", {
            address: contractAddress,
            constructorArguments: args,
        })
    } catch (e) {
        if (e.message.toLowerCase().includes("already verified")) {
            console.log("already verified")
        } else {
            console.log(e)
        }
    }
}

main()
    .then(() => process.exit(0))
    .catch((error) => {
        console.log(error)
        process.exit(0)
    })
