// SPDX-License-Identifier: MIT
pragma solidity ^0.8;

// 自定义修饰符
// 自定义修饰符（Modifier）用于在函数执行前或执行后添加额外的检查或逻辑。它可以复用代码，并且常用于权限控制或状态检查

contract Owner {
    address public owner;

    constructor() {
        owner = msg.sender;
    }

    // 自定义修饰符，仅允许合约所有者调用
    modifier onlyOwner {
        require(msg.sender == owner, "Only owner can call this function");
        _;
    }

    function changeOwner(address newOwner) public onlyOwner {
        owner = newOwner;
    }
}