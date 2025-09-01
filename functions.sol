// SPDX-License-Identifier: MIT
pragma solidity >=0.8.0 <0.9.0;

contract TestFunctions {
    function privateFunction() private pure returns (string memory) {
        return "Private";
    }
    
    function internalFunction() internal pure returns (string memory) {
        return "Internal";
    }
    
    function externalFunction() external pure returns (string memory) {
        return "External";
    }
    
    function publicFunction() public pure returns (string memory) {
        return "Public";
    }

    uint256 private data;

    function setData(uint256 _data) external {
        data = _data;  // 修改状态变量
    }

    function getData() external view returns (uint256) {
        return data;  // 读取状态变量
    }

    function add(uint256 a, uint256 b) external pure returns (uint256) {
        return a + b;  // 纯计算函数
    }

    function deposit() external payable {
        // 接收以太币
    }
}