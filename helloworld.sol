// SPDX-License-Identifier: MIT
pragma solidity >=0.8.0 <0.9.0;

contract HelloWorld3Dot0 {
    string public hello = "HelloWorld!";

    bool public flag = true;

    // address owner = 0x4838B106FCe9647Bdf1E7877BF73cE8B0BAD5f97;

    // address payable wallet = payable(owner);

    bytes1 public b = hex"10";
    bytes1 public b1 = 0x10;
    bytes1 public a = b[0];
    bytes32 public b2 = keccak256("0x4838B106FCe9647Bdf1E7877BF73cE8B0BAD5f97");

    // 状态变量（默认 storage）
    uint256[] numbers;
    uint256 public length = numbers.length;
    // 定长数组
    bytes32[5] fixedArray;
    uint256 public length2 = fixedArray.length;

    // mapping(_KeyType => _ValueType)
    mapping(address => uint256) public balances;
    mapping(uint256 => mapping(bool => string)) public nestedMap;
}