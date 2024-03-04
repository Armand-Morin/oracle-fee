// SPDX-License-Identifier: MIT
pragma solidity ^0.8.7;

import "@chainlink/contracts/src/v0.8/ChainlinkClient.sol";

contract FeeRequester is ChainlinkClient {
    using Chainlink for Chainlink.Request;

    // Chainlink parameters (set these to the appropriate values for your Chainlink node)
    address private oracle = 0x123...; // Oracle Address obtained from Chainlink Market
    bytes32 private jobId = "abc123..."; // Job ID for HTTP GET + JSON Parse
    uint256 private fee = 0.1 * 10 ** 18; // Fee, often 0.1 LINK, but check the specific Oracle's requirement

    // The fee returned from the API
    uint256 public returnedFee;

    constructor() {
        setPublicChainlinkToken();
    }

    function requestFee() public {
        Chainlink.Request memory req = buildChainlinkRequest(jobId, address(this), this.fulfill.selector);
        // Set the URL to your API endpoint
        req.add("get", "http://localhost:5000/compute-fee");
        // Set the path in the JSON response to find the fee
        req.add("path", "fee");
        sendChainlinkRequestTo(oracle, req, fee);
    }

    function fulfill(bytes32 _requestId, uint256 _fee) public recordChainlinkFulfillment(_requestId) {
        returnedFee = _fee;
    }
}
