// SPDX-License-Identifier: MIT
pragma solidity ^0.8;

// 继承

// 父合约
contract Ownable {
    address public owner;

    constructor() {
        owner = msg.sender;
    }

    modifier onlyOwner() {
        require(msg.sender == owner, "Only owner can call this function");
        _; // 如果满足条件，继续执行函数主体
    }
}

// 子合约
contract MyContract is Ownable {
    // 继承了 onlyOwner 自定义修饰符
    function changeOwner(address newOwner) public onlyOwner {
        owner = newOwner;
    }
}