// SPDX-License-Identifier: MIT

pragma solidity ^0.8.8;

import "@chainlink/contracts/src/v0.8/interfaces/AggregatorV3Interface.sol";

library PriceConverter {
    function getPrice(AggregatorV3Interface priceFeed)
        internal
        view
        returns (uint256)
    {
        // this is an instance to call the price of the ETH we need two things
        // we need ABI and address of the contract
        // Address : 0x8A753747A1Fa494EC906cE90E9f37563A8AF630e
        // ABI :
        // // https://docs.chain.link/docs/ethereum-addresses/
        // AggregatorV3Interface priceFeed = AggregatorV3Interface(priceFeed);
        // (uint80 roundId, int price, unit startedAt, uint timestamp, uint80 answeredInRound) = priceFeed.latestRoundDate();
        (, int256 price, , , ) = priceFeed.latestRoundData();
        // ETH price of USD
        // 3000.00000000
        return uint256(price * 1e10); // 1**10
    }

    function getConversionRate(
        uint256 ethAmount,
        AggregatorV3Interface priceFeed
    ) internal view returns (uint256) {
        uint256 ethPrice = getPrice(priceFeed);
        uint256 ethAmountInUSD = (ethPrice * ethAmount) / 1e18;
        return ethAmountInUSD;
    }
}
