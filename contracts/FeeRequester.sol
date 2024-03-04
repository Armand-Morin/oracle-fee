// SPDX-License-Identifier: MIT
pragma solidity ^0.8.7;

import "@chainlink/contracts/src/v0.8/ChainlinkClient.sol";

contract FeeRequester is ChainlinkClient {
    using Chainlink for Chainlink.Request;

    address private oracle;
    bytes32 private jobId;
    uint256 private fee;

    // The fee returned from the API
    uint256 public returnedFee;

    // Event to be emitted when the fee is returned
    event FeeReturned(uint256 fee);

    constructor(address _oracle, bytes32 _jobId, uint256 _fee, address _linkToken) {
        setChainlinkOracle(_oracle);
        jobId = _jobId;
        fee = _fee;
        // Initialize the LinkToken
        setChainlinkToken(_linkToken);
    }

    function requestFee() public {
        Chainlink.Request memory req = buildChainlinkRequest(jobId, address(this), this.fulfill.selector);
        req.add("get", "https://5ea2-2001-5a8-4606-8e00-91be-5748-ca58-d382.ngrok-free.app/compute-fee");
        req.add("path", "fee");
        sendChainlinkRequestTo(oracle, req, fee);
    }

    function fulfill(bytes32 _requestId, uint256 _fee) public recordChainlinkFulfillment(_requestId) {
        returnedFee = _fee;
        emit FeeReturned(_fee); // Emitting the event with the returned fee
    }
}
