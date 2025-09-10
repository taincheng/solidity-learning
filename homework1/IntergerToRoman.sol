// SPDX-License-Identifier: MIT
pragma solidity ^0.8;

contract IntergerToRoman {


     // 根据字节返回罗马数字对应的值
    function getValue(uint256 c) private pure returns (bytes1) {
        if (c == 1) return 'I';
        if (c == 5) return 'V';
        if (c == 10) return 'X';
        if (c == 50) return 'L';
        if (c == 100) return 'C';
        if (c == 500) return 'D';
        if (c == 1000) return 'M';
        return '-'; 
    }

    function intergerToRoman(uint256 num) external pure returns (string memory) {
        uint256 tmp = num;
        bytes memory res = new bytes(16);
        uint8 index = 0;
        while (tmp > 0) {
            
        }

        reutrun string('');
    }
}