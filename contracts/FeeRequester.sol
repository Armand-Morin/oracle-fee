// SPDX-License-Identifier: MIT
pragma solidity ^0.8.7;

import "@chainlink/contracts/src/v0.8/ChainlinkClient.sol";

contract FeeRequester is ChainlinkClient {
    using Chainlink for Chainlink.Request;

    // Hardcoded values
    address private constant oracle = 0x6090149792dAAeE9D1D568c9f9a6F6B46AA29eFD;
    bytes32 private constant jobId = "ca98366cc7314957b8c012c72f05aeeb";
    uint256 private constant fee = 0.1 ether; // Assuming the fee is 0.1 LINK
    address private constant linkTokenAddress = 0x326C977E6efc84E512bB9C30f76E30c160eD06FB; // Example LINK token address, replace with actual address for your network

    uint256 public returnedFee;

    event FeeCalculated(uint256 fee);

    constructor() {
        setChainlinkToken(linkTokenAddress);
        setChainlinkOracle(oracle);
    }

    // Adjusted to pass inputs to the API
    function requestFeeWithParameters(uint256 amountUSD, uint256 priceDiff, uint256 std) public {
        Chainlink.Request memory req = buildChainlinkRequest(jobId, address(this), this.fulfill.selector);
        req.add("get", "https://5ea2-2001-5a8-4606-8e00-91be-5748-ca58-d382.ngrok-free.app/compute-fee"); // Replace with your actual API URL
        // Assuming your API can accept query parameters for amountUSD, priceDiff, and std
        string memory urlWithParams = string(abi.encodePacked(
            "https://your-api-url.com/path?",
            "amountUSD=", uint2str(amountUSD),
            "&priceDiff=", uint2str(priceDiff),
            "&std=", uint2str(std)
        ));
        req.add("get", urlWithParams);
        req.add("path", "fee"); // Adjust based on the JSON response structure
        sendChainlinkRequestTo(oracle, req, fee);
    }

    function fulfill(bytes32 _requestId, uint256 _fee) public recordChainlinkFulfillment(_requestId) {
        emit FeeCalculated(_fee);
    }

    // Utility function to convert uint256 to string
    function uint2str(uint256 _i) internal pure returns (string memory str) {
        if (_i == 0) {
            return "0";
        }
        uint256 j = _i;
        uint256 length;
        while (j != 0) {
            length++;
            j /= 10;
        }
        bytes memory bstr = new bytes(length);
        uint256 k = length;
        while (_i != 0) {
            k = k-1;
            uint8 temp = (48 + uint8(_i - _i / 10 * 10));
            bytes1 b1 = bytes1(temp);
            bstr[k] = b1;
            _i /= 10;
        }
        str = string(bstr);
    }
}
