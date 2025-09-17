// SPDX-License-Identifier: MIT
pragma solidity ^0.8;

contract Vault {
    address public owner;

    constructor() {
        owner = msg.sender;
    }

    receive() external payable {}

    function withdraw() external {
        require(msg.sender == owner, "Not owner");
        (bool success, ) = payable(owner).call{value: address(this).balance}("");
        require(success, "Withdraw failed");
    }

    function getBalance() external view returns (uint) {
        return address(this).balance;
    }
}