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

    event RequestFeeCompleted(bytes32 indexed requestId, uint256 fee);

    constructor() {
        setChainlinkToken(linkTokenAddress);
        setChainlinkOracle(oracle);
    }

    function requestFee() public {
        Chainlink.Request memory req = buildChainlinkRequest(jobId, address(this), this.fulfill.selector);
        req.add("get", "https://5ea2-2001-5a8-4606-8e00-91be-5748-ca58-d382.ngrok-free.app/compute-fee"); // Replace with your actual API URL
        req.add("path", "fee");
        sendChainlinkRequestTo(oracle, req, fee);
    }

    function fulfill(bytes32 _requestId, uint256 _fee) public recordChainlinkFulfillment(_requestId) {
        returnedFee = _fee;
        emit RequestFeeCompleted(_requestId, _fee);
    }
}
