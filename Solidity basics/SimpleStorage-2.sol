// SPDX-License-Identifier: MIT

pragma solidity ^0.8.8; // Specific version
// pragma solidity ^0.8.7; // any version grater than or equal to the given version
// pragma solidity >=0.8.7 <0.9.0; // any version btw the given versions

contract SimpleStorage {

    People public person = People({favoriteNumber: 2, name: "Abhi"});
    
    struct People {
        uint256 favoriteNumber;
        string name;
    }

    // dynamic array
    People[] public people;
    // static array
    // People[3] public people;

    // what is memory?
    // this is used to hold temporary values. It is erased between (external) function calls and is cheaper to use.
    function addPerson(string memory _name, uint256 _favoriteNumber) public {
        People memory newPerson = People({favoriteNumber: _favoriteNumber, name:_name});
        people.push(newPerson);
    }
    // calldata and memory exits only temp during the function
    // calldata is temp variables that can't be changed its value.
    // memory is a temp variable that can be changed within the function.
    // storage is a perment variable that can be modified   
    // In a function we can't have a storage for function paramaters
    // data location can only be specified for array, struct or mapping types.
    // int, uint dont need to be provided with data location

}
