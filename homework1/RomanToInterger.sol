// SPDX-License-Identifier: MIT
pragma solidity ^0.8;

// 用 solidity 实现整数转罗马数字
// 题目描述在 https://leetcode.cn/problems/roman-to-integer/description/3.

contract RomanToInteger {

    // 根据字节返回罗马数字对应的值
    function getRomanValue(bytes1 c) private pure returns (uint256) {
        if (c == 'I') return 1;
        if (c == 'V') return 5;
        if (c == 'X') return 10;
        if (c == 'L') return 50;
        if (c == 'C') return 100;
        if (c == 'D') return 500;
        if (c == 'M') return 1000;
        return 0; 
    }
    
    function romanToInteger(string memory romanStr) external pure returns (uint) {
        bytes memory romanBytes = bytes(romanStr);
        uint256 sum = 0;
        for (uint256 i = 0; i < romanBytes.length; i ++) {
            uint256 curRoman = getRomanValue(romanBytes[i]);
            if (i + 1 < romanBytes.length) {
                if (curRoman < getRomanValue(romanBytes[i + 1])) {
                    sum -= curRoman;
                } else {
                    sum += curRoman;
                }
            } else {
                sum += curRoman;
            }
        }
        return sum;
    }
}