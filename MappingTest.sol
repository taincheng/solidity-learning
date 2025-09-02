// SPDX-License-Identifier: MIT
pragma solidity ~0.8.0;

// Mapping 映射
contract MappingTets {

    // Mapping 只能在 storage 中定义
    mapping(address account => int256 amount) public balances1;

    // 嵌套 Mapping
    mapping(address account => mapping(string name=> int256 amount)) public balances2;

    // 只能通过函数添加和修改 Mapping 的值
    function setMappingValue(address _adr, int256 amount) public  {
        balances1[_adr] = amount;
    }

    function setBalances2(address _adr, string memory currency, int256 amount) public {
        balances2[_adr][currency]=amount;
    }

    // 删除 Mapping 中的元素，实际上是把对应的 value 设置为默认值,不会真正删除 key
    function deleteBlances2(address _adr, string memory currency) public {
        delete balances2[_adr][currency];
    }
}