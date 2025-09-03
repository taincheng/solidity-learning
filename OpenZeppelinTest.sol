// SPDX-License-Identifier: MIT
pragma solidity ^0.8;

// OpenZeppelin 是一个广泛使用的 Solidity 库，提供了许多经过审计的智能合约模板，如 ERC20、ERC721、Ownable 等。
// 使用 OpenZeppelin 可以大大减少开发时间并提高合约的安全性。

// 引入 OpenZeppelin 的 ERC20 合约
import "@openzeppelin/contracts/token/ERC20/ERC20.sol";

contract MyToken is ERC20 {
    constructor() ERC20("MyToken", "MTK") {
        _mint(msg.sender, 1000000 * 10 ** decimals());
    }
}