// SPDX-License-Identifier: MIT
pragma solidity ^0.8.7;

// import "@chainlink/contracts/src/v0.8/ChainlinkClient.sol";
import "smartcontractkit/chainlink-brownie-contracts@1.1.1/contracts/src/v0.8/ChainlinkClient.sol";


contract FeeRequester is ChainlinkClient {
    using Chainlink for Chainlink.Request;

    // Replace with the actual Oracle address and Job ID from a Chainlink node that supports your request
    address private oracle;
    bytes32 private jobId;
    uint256 private fee;

    // The fee returned from the API
    uint256 public returnedFee;

    constructor(address _oracle, bytes32 _jobId, uint256 _fee, address _linkToken) {
        setChainlinkOracle(_oracle);
        jobId = _jobId;
        fee = _fee;
        // Initialize the LinkToken
        setChainlinkToken(_linkToken);
    }

    function requestFee() public {
        Chainlink.Request memory req = buildChainlinkRequest(jobId, address(this), this.fulfill.selector);
        // Ensure your API is accessible publicly and replace the URL here
        req.add("get", "http://your-public-api-url/compute-fee");
        req.add("path", "fee");
        sendChainlinkRequestTo(oracle, req, fee);
    }

    function fulfill(bytes32 _requestId, uint256 _fee) public recordChainlinkFulfillment(_requestId) {
        returnedFee = _fee;
    }
}
