// SPDX-License-Identifier: MIT
pragma solidity ^0.8;

import "@openzeppelin/contracts/security/ReentrancyGuard.sol";

// 被攻击的合约
contract VulnerableVault is ReentrancyGuard {
    mapping(address => uint) public balances;

    function deposit() external payable {
        balances[msg.sender] += msg.value;
    }

    function withdraw() external {
        require(balances[msg.sender] > 0, "No balance");

        // 发送 ETH（外部调用，容易被攻击者重入）
        (bool success, ) = msg.sender.call{value: balances[msg.sender]}("");
        require(success, "Transfer failed");

        // 更新余额（放在调用后，导致漏洞）
        balances[msg.sender] = 0;
    }

    // 方案 1
    function withdrawFix() external {
        require(balances[msg.sender] > 0, "No balance");

        uint256 balance = balances[msg.sender];
        // 先更新余额，再操作
        balances[msg.sender] = 0;

        // 发送 ETH
        (bool success, ) = msg.sender.call{value: balance}("");
        require(success, "Transfer failed");
    }

    // 方案 2 使用openzeppelin实现的方案 nonReentrant
    function withdrawFix2() external nonReentrant {
        uint amount = balances[msg.sender];
        require(amount > 0, "No balance");
        balances[msg.sender] = 0;
        (bool success, ) = msg.sender.call{value: amount}("");
        require(success, "Transfer failed");
    }
}

// 发起的合约
contract Attacker {
    VulnerableVault public target;

    constructor(address _target) {
        target = VulnerableVault(_target);
    }

    // 回调函数，趁机再次提取
    receive() external payable {
        if (address(target).balance >= 1 ether) {
            target.withdraw();
        }
    }

    function attack() external payable {
        require(msg.value >= 1 ether, "Need 1 ETH");
        // deposit 被 payable标记，就可以用 {value: 1 ether} 来发送一定数量的以太币
        target.deposit{value: 1 ether}();
        target.withdrawFix();
    }
}