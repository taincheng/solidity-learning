// SPDX-License-Identifier: MIT
pragma solidity ^0.8;

// 反转字符串 (Reverse String)
// 题目描述：反转一个字符串。输入 "abcde"，输出 "edcba"

contract ReverseString {
    function reverseString(string calldata str) external pure returns (string memory) {
        bytes memory tmpBytes = bytes(str);
        for (uint i = 0; i < tmpBytes.length / 2; i++) {
            // solidity 支持元组赋值
            (tmpBytes[i], tmpBytes[tmpBytes.length - 1 - i]) = (tmpBytes[tmpBytes.length - 1 - i], tmpBytes[i]);
        }
        return string(tmpBytes);
    }
}
