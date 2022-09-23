const { ethers } = require("hardhat")
const { expect, assert } = require("chai")
describe("SimpleStorage", () => {
    let simpleStorageFactory, simpleStorage
    beforeEach(async function () {
        simpleStorageFactory = await ethers.getContractFactory("SimpleStorage")
        simpleStorage = await simpleStorageFactory.deploy()
    })

    it("Should start with a favorite number of 0", async function () {
        const currentValue = await simpleStorage.retrieve()
        assert.equal(currentValue.toString(), "0")
    })

    it("Should update when we call store", async function () {
        const expectedValue = "7"
        const transactionResponse = await simpleStorage.store(expectedValue)
        await transactionResponse.wait(1)

        const currentValue = await simpleStorage.retrieve()
        assert.equal(currentValue.toString(), expectedValue)
    })

    it("Should Add new user", async function () {
        const people = {
            name: "Abhi",
            favoriteNumber: "7",
        }
        const transactionResponse = await simpleStorage.addPerson(
            people.name,
            people.favoriteNumber
        )
        await transactionResponse.wait(1)

        const currentPeople = await simpleStorage.people(0)
        assert.equal(currentPeople.name.toString(), people.name)
        assert.equal(
            currentPeople.favoriteNumber.toString(),
            people.favoriteNumber
        )
    })
})
