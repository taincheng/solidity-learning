// SPDX-License-Identifier: MIT
pragma solidity ^0.8;

// 接口只能声明函数，不能实现函数。
// 接口中的函数必须标记为 `external`。
// 接口不能定义状态变量或构造函数。
// 接口可以继承其他接口。

// 定义一个简单的银行接口
interface IBank {
    // 存钱
    function deposit() external payable;
    // 取钱
    function withdraw(uint256 amount) external;
    // 查询余额
    function getBalance() external view returns (uint256);
}

// 实现银行接口
contract Bank is IBank {

    mapping(address => uint256) public balances;

    function deposit() external payable override {
        require(msg.value > 0, "deposti amount must grade than 0");
        balances[msg.sender] += msg.value;
    }

    function withdraw(uint256 amount) external override {
        require(amount > 0, "withdraw amount must grade than 0");
        require(balances[msg.sender] >= amount, "insufficient balance");
        balances[msg.sender] -= amount;
        payable(msg.sender).transfer(amount);
    }

    function getBalance() external view override returns (uint256) {
        return balances[msg.sender];
    }
}