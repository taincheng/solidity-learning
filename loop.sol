// SPDX-License-Identifier: MIT
pragma solidity ^0.8;

contract ForLoopTest {
    // for 


    function addFor1() public pure returns(uint256) {
        uint256 sum = 0;
        for (uint8 i = 0; i <= 10; i ++) {
            sum += i;
        }
        return sum;
    }

    function addFor2() public pure returns(uint256) {
        uint256 sum = 0;
        uint8 i = 0;
        for (; i <= 10; ) {
            sum += i;
            i ++;
        }
        return sum;
    }

    function addFor3() public pure returns(uint256) {
        uint256 sum = 0;
        uint8 i = 0;
        for ( ; ; ) {
            if (i > 10) {
                break;
            }
            sum += i;
            i ++;
        }
        return sum;
    }

    // do while

    function addDoWhile() public pure returns(uint) {
        uint256 sum = 0;
        uint8 i = 0;
        do {
            sum += i;
            i ++;
        } while (i <= 10);
        return sum;
    }

    // while
    function addWhile() public pure returns(uint) {
        uint256 sum = 0;
        uint8 i = 0;
        while(i<=10) {
            sum += i;
            i ++;
        }
        return sum;
    }
}