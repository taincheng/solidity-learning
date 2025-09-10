// SPDX-License-Identifier: MIT
pragma solidity ^0.8;

contract IntergerToRoman {


    uint256[] values = [1000, 900, 500, 400, 100, 90, 50, 40, 10, 9, 5, 4, 1];
    string[] symbols = ["M", "CM", "D", "CD", "C", "XC", "L", "XL", "X", "IX", "V", "IV", "I"];

    function intergerToRoman(uint256 num) external view returns (string memory) {
        string memory result = "";
        for (uint8 i = 0; i < values.length; i ++) {
            while (num >= values[i]) {
                num -= values[i];
                result = string(abi.encodePacked(result, symbols[i]));
            }

            if (num == 0) {
                break;
            }
        }
        return result;
    }
}