// SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

// Inherit

import "./SimpleStorage.sol";

contract ExtraStorage is SimpleStorage {
    // add +5 to any of the favorite 
    // two keywords virtual and override

    function store(uint256 _favoriteNumber) public override {
        favoriteNumber = _favoriteNumber + 5;
    }
}