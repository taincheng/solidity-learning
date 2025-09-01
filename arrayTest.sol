// SPDX-License-Identifier: MIT
pragma solidity ~0.8.0;

contract ArrayTest {
    // 静态数组

    // 声明
    uint8[3] public arr;

    // 声明初始化
    uint8[3] public arr1 = [1, 2, 3];

    // 动态数组
    uint8[] public arr3;
    uint8[] public arr4 = [1, 2, 3];
    uint8[] public arr5 = new uint8[](5);

    function createArr() external pure returns (uint256 len) {
        // 内存中创建长度为3的动态数组
        uint8[] memory tempArray = new uint8[](3);
        // 按照下标赋值
        tempArray[0] = 10;

        return tempArray.length;
    }

    function readArr3() external view returns (uint256 len) {
        return arr5.length;
    }

    // 特殊数组类型

    // bytes
    bytes public bs = "abc\x22\x22"; // 通过十六进制字符串初始化
    bytes public _data = new bytes(10); // 创建一个长度为 10 的字节数组

    function readBytesByIndex(uint256 i) external view returns (bytes1) {
        return bs[i];
    }

    // string
    string public str0;
    string public str1 = "TinyXiong\u718A"; // 使用Unicode编码值

    // 数组切片
    function testSlice(
        bytes calldata data,
        uint256 start,
        uint256 end
    ) external pure returns (bytes memory) {
        return data[start:end]; // Works because `data` is `calldata`
    }

    function testSlice(uint256 start, uint256 end)
        external
        view
        returns (bytes memory)
    {
        require(end <= bs.length, "End index out of bounds");
        require(start < end, "Invalid range");

        bytes memory slice = new bytes(end - start);
        for (uint256 i = 0; i < slice.length; i++) {
            slice[i] = bs[start + i];
        }
        return slice;
    }
}
