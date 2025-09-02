// SPDX-License-Identifier: MIT
pragma solidity ^0.8;

// - 任务 1：创建一个合约，定义一个结构体用于存储产品信息，包括产品 ID、名称、价格和库存。实现增加、修改和查询产品信息的功能。
// - 任务 2：扩展合约，定义一个结构体用于存储订单信息，并实现订单的创建和查询功能，考虑如何设计结构体以便有效存储和访问订单数据。
// - 任务 3：设计一个用户管理合约，使用结构体记录用户的个人信息、余额及交易历史，探索如何优化结构体的设计以减少存储成本。

// 结构体
contract StructTest {
    struct Product {
        uint256 id;
        string name;
        uint256 price;
        uint256 count;
    }
    mapping(uint256 => Product) public products;
    uint256 productCount = 0;


    // 增加产品
    function addNewProduct(uint256 _id, string memory _name, uint256 _price, uint256 _count) external returns(uint256) {
        productCount ++;
        products[productCount] = Product(_id, _name, _price, _count);
        return productCount;
    }


    // 修改产品
    function changeProductInfo(uint256 _productCount, string memory _name, uint256 _price, uint256 _count) external {
        Product storage product = products[_productCount];
        product.name = _name;
        product.price = _price;
        product.count = _count;
    }

    // 查询产品
    function getProductInfo(uint256 _productCount) external view returns(uint256, string memory, uint256, uint256) {
        Product storage product = products[_productCount];
        return (product.id, product.name, product.price, product.count);
    }
}