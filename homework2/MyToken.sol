// SPDX-License-Identifier: MIT
pragma solidity ^0.8;
import "@openzeppelin/contracts/token/ERC20/ERC20.sol";

/* 
任务：参考 openzeppelin-contracts/contracts/token/ERC20/IERC20.sol实现一个简单的 ERC20 代币合约。要求：
合约包含以下标准 ERC20 功能：
balanceOf：查询账户余额。
transfer：转账。
approve 和 transferFrom：授权和代扣转账。
使用 event 记录转账和授权操作。
提供 mint 函数，允许合约所有者增发代币。
提示：
使用 mapping 存储账户余额和授权信息。
使用 event 定义 Transfer 和 Approval 事件。
部署到sepolia 测试网，导入到自己的钱包
*/
contract MyToken {

    address private contractOwner;

    // 合约账本
    mapping(address account => uint256) private _balances;

    // 合约代扣账本
    mapping(address ower => mapping(address spender => uint256)) private _allowances;
    uint256 private _totalSupply;

    string private _name;
    string private _symbol;

    constructor(string memory name_, string memory symbol_) {
        _name = name_;
        _symbol = symbol_;
        contractOwner = msg.sender;
        _mint(msg.sender, 1000000000000000000000000000);
    }

    modifier onlyOwner() {
        require(contractOwner == msg.sender, "only owner");
        _;
    }

    // 获取余额
    function balanceOf(address _account) public view returns(uint256) {
        return _balances[_account];
    }

    function allowancesOf(address _owner, address _spender) public view returns(uint256) {
        return _allowances[_owner][_spender];
    }

    // 转账
    function transfer(address _to, uint256 _amount) public returns(bool) {
        address owner = msg.sender;
        _transfer(owner, _to, _amount);
        return true;
    }

    // 转账逻辑
    function _transfer(address _from, address _to, uint256 _amount) internal {
        // 检查转出转入账户是否为 0 地址，如果是就终止
        if (_from == address(0)) {
            revert("from is zero address");
        }
        if (_to == address(0)) {
            revert("to is zero address");
        }
        _update(_from, _to, _amount);
    }

    // 铸造币或者销毁币，转账逻辑
    function _update(address _from, address _to, uint256 _amount) internal {
        if (_from == address(0)) {
            // 转入账户为零地址，是铸币的情况
            _totalSupply += _amount;
        } else {
            uint256 fromBalance = _balances[_from];
            if (fromBalance < _amount) {
                revert("From transaction cannot be completed due to insufficient balance");
            }
            unchecked {
                _balances[_from] = fromBalance - _amount;
            }
        }
        if (_to == address(0)) {
            // 转出账户为零地址，是销毁币的情况
            unchecked {
               _totalSupply -= _amount; 
            }
        } else {
            unchecked {
                _balances[_to] += _amount;
            }
        }
        emit Transfer(_from, _to, _amount);
    }

    // 授权
    function approve(address _spender, uint256 _amount) public returns(bool) {
        address owner = msg.sender;
        _approve(owner, _spender, _amount);
        return true;
    }

    function _approve(address _owner, address _spender, uint256 _amount) internal {
        // 检查授权账户和被授权账户是否为零地址
        if (_owner == address(0)) {
            revert("_owner is zero address");
        }
        if (_spender == address(0)) {
            revert("_spender is zero address");
        }
        _allowances[_owner][_spender] = _amount;
        emit Approval(_owner, _spender, _amount);
    }

    // 代扣转账。
    function transferFrom(address _from, address _to, uint256 _amount) public returns(bool) {
        address spender = msg.sender;
        // 扣减代扣额度
        _spendAllowance(_from, spender, _amount);
        // 转账
        _transfer(_from, _to, _amount);
        return true;
    }

    // 扣减代扣额度
    function _spendAllowance(address _from, address _spender, uint256 _amount) internal {
        // 获取授权代扣的额度
        uint256 allowAmount = _allowances[_from][_spender];
        if (allowAmount < type(uint256).max) {
            if (allowAmount < _amount) {
                revert("allow insufficient amount");
            }
            unchecked {
                _approve(_from, _spender, allowAmount - _amount);
            }
        }
    }

    // 铸币, 只有合约所有者可以铸币
    function _mint(address _account, uint256 _amount) public onlyOwner {
        _update(address(0), _account, _amount);
    }

    event Transfer(address indexed from, address indexed to, uint256 value);

    event Approval(address indexed owner, address indexed spender, uint256 value);

}