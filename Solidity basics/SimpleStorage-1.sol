// SPDX-License-Identifier: MIT

pragma solidity ^0.8.8; // Specific version
// pragma solidity ^0.8.7; // any version grater than or equal to the given version
// pragma solidity >=0.8.7 <0.9.0; // any version btw the given versions

contract SimpleStorage {
    /*
    // boolean, unit, int, address, bytes
    bool hasFavoriteNumber = true;
    uint favoriteNumber = 123; // default to unit256, else you can use it on 8,16,32,64,128,256
    string favoriteString = "Hello";
    int256 favoriteInt = -5;
    address myAddress = 0x042B13939dc5789de524E44beBD0fc18b672bf35;
    bytes32 favoriteBytes = "cat"; // typically looks like 0x12432343234234 there is no bytes64 
    */

    uint256 public favoriteNumber; // visible in public. by default variables are internal type

    function store(uint256 _favoriteNumber) public {
        favoriteNumber = _favoriteNumber;
        // if we call a view function or a pure function then the network will consume gas
        // retrive();
    }


    // view and pure keywords doesnot consume any gas.
    // only when we modify the blockchain only then the gas is consumed.
    function retrive() public view returns(uint256) {
        return favoriteNumber;
    }

}
