// SPDX-License-Identifier: MIT
pragma solidity ^0.8;

contract BinarySearch {

    function binarySearch(int256[] memory array, int256 num) external pure returns (int256 index) {
        uint256 left = 0;
        uint256 right = array.length - 1;

        while (left <= right) {
            uint256 midIndex = (left + right) / 2;
            if (array[midIndex] == num) {
                return int256(midIndex); 
            } else {
                if (array[midIndex] > num) {
                    right = midIndex - 1;
                } else {
                    left = midIndex + 1;
                }
            }
        }
        return -1;
    }
}