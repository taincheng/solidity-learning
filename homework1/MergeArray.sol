// SPDX-License-Identifier: MIT
pragma solidity ^0.8;

// 合并两个有序数组 (Merge Sorted Array)
// 题目描述：将两个有序数组合并为一个有序数组。

contract MergeArray {
    function mergeSortArray(uint256[] memory nums1, uint256[] memory nums2) public pure returns (uint[] memory) {
        uint256[] memory result = new uint256[](nums1.length + nums2.length);
        uint8 i = 0;
        uint8 j = 0;

        while (i < nums1.length && j < nums2.length) {
            if (nums1[i] < nums2[j]) {
                result[i + j] = nums1[i];
                i ++;
            } else {
                result[i + j] = nums2[j];
                j ++;
            }
        }

        if (i < nums1.length) {
            while (i < nums1.length) {
                result[i + j] = nums1[i];
                i ++;
            }
        }

        if (j < nums2.length) {
            while (j < nums2.length) {
                result[i + j] = nums2[j];
                j ++;
            }
        }
        return result;
    }
}