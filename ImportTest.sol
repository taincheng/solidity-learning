// SPDX-License-Identifier: MIT
pragma solidity ^0.8;

// 引入本地文件
import './InterfaceTest.sol';

// 引入远程文件
import "https://github.com/OpenZeppelin/openzeppelin-contracts/blob/master/contracts/token/ERC20/ERC20.sol";


// 引入整个目录
// import "./utils/*";

// 引入并重命名
import { Bank as bank } from "./InterfaceTest.sol";

contract ImportTest {

    // 使用重命名后的名称
    bank public bank1;

    function getBlance() external view returns(uint256) {
        return bank1.getBalance();
    }
}