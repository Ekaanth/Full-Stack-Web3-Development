// SPDX-License-Identifier: MIT

pragma solidity ^0.8.8; // Specific version
// pragma solidity ^0.8.7; // any version grater than or equal to the given version
// pragma solidity >=0.8.7 <0.9.0; // any version btw the given versions

contract SimpleStorage {

    mapping(string => uint256) public nameToFavoriteNumber;
    
    struct People {
        uint256 favoriteNumber;
        string name;
    }

    People[] public people;
    
    function addPerson(string memory _name, uint256 _favoriteNumber) public {
        people.push(People(_favoriteNumber, _name));
        nameToFavoriteNumber[_name] = _favoriteNumber;
    }
}