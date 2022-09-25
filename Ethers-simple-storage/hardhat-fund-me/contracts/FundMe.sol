// SPDX-License-Identifier: MIT

// get funds from user
// withdraw funds
// set a minimum funding value in USD

pragma solidity ^0.8.8;

import "./PriceConverter.sol";
import "@chainlink/contracts/src/v0.8/interfaces/AggregatorV3Interface.sol";

error NotOwner();

// constant and immutable keyword
// using const and immutable keyword helps us in save the gas

contract FundMe {
    using PriceConverter for uint256;
    uint256 public constant MINIMUMUSD = 10 * 1e18;
    address[] public funders;
    mapping(address => uint256) public addressToAmountFunded;
    address public immutable iOwner;

    AggregatorV3Interface public priceFeed;

    constructor(address priceFeedAddress) {
        iOwner = msg.sender;
        priceFeed = AggregatorV3Interface(priceFeedAddress);
    }

    function fund() public payable {
        // want to be able to set a minumum amount
        // 1. how do we send ETH to this contract?
        require(
            msg.value.getConversionRate(priceFeed) >= MINIMUMUSD,
            "Didn't send enough"
        ); // 1e18 == 1*10*18
        funders.push(msg.sender);
        addressToAmountFunded[msg.sender] = msg.value;
    }

    function withdraw() public onlyOwner {
        for (
            uint256 funderIndex = 0;
            funderIndex < funders.length;
            funderIndex++
        ) {
            address funder = funders[funderIndex];
            addressToAmountFunded[funder] = 0;
        }
        funders = new address[](0);
        // // transfer
        // payable(msg.sender).transfer(address(this).balance);
        // // send
        // bool sendSuccess = payable(msg.sender).send(address(this).balance);
        // require(sendSuccess, "Send failed");
        // call
        (bool callSuccess, ) = payable(msg.sender).call{
            value: address(this).balance
        }("");
        require(callSuccess, "Call failed");
    }

    // depends on the order
    // if the _ is on top the code is run and then the require is applied
    modifier onlyOwner() {
        if (msg.sender != iOwner) revert NotOwner();
        // require(msg.sender == i_owner, "Not a Owner");
        _; // means doing the rest of the code.
    }

    // what happens if someone sends this contract with ETH with out using the function that are defined

    receive() external payable {
        fund();
    }

    fallback() external payable {
        fund();
    }
}
