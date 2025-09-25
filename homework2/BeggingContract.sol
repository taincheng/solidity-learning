// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "@openzeppelin/contracts/utils/Strings.sol";
/*
### ✅ 作业3：编写一个讨饭合约
任务目标
1. 使用 Solidity 编写一个合约，允许用户向合约地址发送以太币。
2. 记录每个捐赠者的地址和捐赠金额。
3. 允许合约所有者提取所有捐赠的资金。

任务步骤
1. 编写合约
  - 创建一个名为 BeggingContract 的合约。
  - 合约应包含以下功能：
  - 一个 mapping 来记录每个捐赠者的捐赠金额。
  - 一个 donate 函数，允许用户向合约发送以太币，并记录捐赠信息。
  - 一个 withdraw 函数，允许合约所有者提取所有资金。
  - 一个 getDonation 函数，允许查询某个地址的捐赠金额。
  - 使用 payable 修饰符和 address.transfer 实现支付和提款。
2. 部署合约
  - 在 Remix IDE 中编译合约。
  - 部署合约到 Goerli 或 Sepolia 测试网。
3. 测试合约
  - 使用 MetaMask 向合约发送以太币，测试 donate 功能。
  - 调用 withdraw 函数，测试合约所有者是否可以提取资金。
  - 调用 getDonation 函数，查询某个地址的捐赠金额。

任务要求
1. 合约代码：
  - 使用 mapping 记录捐赠者的地址和金额。
  - 使用 payable 修饰符实现 donate 和 withdraw 函数。
  - 使用 onlyOwner 修饰符限制 withdraw 函数只能由合约所有者调用。
2. 测试网部署：
  - 合约必须部署到 Goerli 或 Sepolia 测试网。
3. 功能测试：
  - 确保 donate、withdraw 和 getDonation 函数正常工作。

提交内容
1. 合约代码：提交 Solidity 合约文件（如 BeggingContract.sol）。
2. 合约地址：提交部署到测试网的合约地址。
3. 测试截图：提交在 Remix 或 Etherscan 上测试合约的截图。

额外挑战（可选）
1. 捐赠事件：添加 Donation 事件，记录每次捐赠的地址和金额。
2. 捐赠排行榜：实现一个功能，显示捐赠金额最多的前 3 个地址。
3. 时间限制：添加一个时间限制，只有在特定时间段内才能捐赠。
*/
contract BeggingContract {
    using Strings for uint256;
    address public owner;
    uint256 public totalDonations;
    uint256 public canWithdrawDonations;

    // 定义早晚捐赠时间
    uint256 internal STARTHOURS = 8;
    uint256 internal ENDTHOURS = 18;

    // 记录每个捐赠者的捐赠金额
    mapping(address donnor => uint256) internal donations;

    // 排行榜
    struct Donor {
        address addr;
        uint256 amount;
    }

    Donor[3] internal topDonor;
    uint256 internal topCount;

    constructor () {
        owner = msg.sender;
    }

    // donate 函数，允许用户向合约发送以太币，并记录捐赠信息
    function donate() public payable {
        require(
            isInDailyPeriod(),
            string(
                abi.encodePacked(
                    "Donation only allowed between ",
                    STARTHOURS.toString(), ":00 and ",
                    ENDTHOURS.toString(), ":00 daily"
                )
            )
        );
        require(msg.value > 0, "Donation amount must be greater than 0");
        donations[msg.sender] += msg.value;
        totalDonations += msg.value;
        canWithdrawDonations += msg.value;

        // 更新捐款排行
        _updateTopDonor(msg.sender, donations[msg.sender]);
        emit Donation(msg.sender, msg.value);
    }

    /**
     * 更新捐献排行榜
     */
    function _updateTopDonor(address _donor, uint256 _amount) internal {
        bool isInTop = false;
        // 如果用户已经存在排行榜上，就地加捐赠数额
        for (uint256 i = 0; i < topCount; i ++) {
            if (topDonor[i].addr == _donor) {
                topDonor[i].amount += _amount;
                isInTop = true;
                break;
            }
        }

        if (!isInTop) {
            // 如果排行榜未满，直接加入末尾
            if (topCount < 3) {
                topDonor[topCount] = Donor(_donor, _amount);
                topCount ++;
            } else if(_amount > topDonor[topCount - 1].amount){
                // 排行榜满了，和最后一位比较，如果大于最后一位，就替换
                topDonor[topCount - 1] = Donor(_donor, _amount);
            }
        }
        
        // 重新排序
        _sortTop();
    }

    // 排序
    function _sortTop() internal {
        for (uint256 i = 1; i < topCount; i ++) {
            Donor memory key = topDonor[i];
            int256 j = int256(i) - 1;
            while (j >= 0 && topDonor[uint256(j)].amount < key.amount) {
                topDonor[uint256(j + 1)] = topDonor[uint256(j)];
                j --;
            }
            topDonor[uint256(j + 1)] = key;
        }
    }

    // 获取前三名
    function getTopSort() public view returns (address[3] memory addrTop, uint256[3] memory amountTop, uint256 count) {
        for (uint256 i = 0; i < topCount; i ++) {
            addrTop[i] = topDonor[i].addr;
            amountTop[i] = topDonor[i].amount;
        }
        count = topCount;
    }


    // withdraw 函数，允许合约所有者提取所有资金
    function withdraw() external onlyOwner {
        require(canWithdrawDonations > 0, "no brand to withdraw");
        uint256 withdrawAmount = canWithdrawDonations;
        canWithdrawDonations = 0;
        payable(owner).transfer(withdrawAmount);
        emit WithDrawDonations(owner, withdrawAmount);
    }

    // getDonation 函数，允许查询某个地址的捐赠金额
    function getDonation(address _account) public view returns (uint256) {
        return donations[_account];
    }


    /**
     * @notice receive 函数，用于处理直接转账     
     */
    receive() external payable {
        // 直接转账会调用 donate 来记录捐赠
        donate();  
    }

    /**
     * @notice fallback 函数，用于兼容非函数匹配的交易
     */
    fallback() external payable {
        // 不支持未定义函数的调用
        revert("Use donate() to contribute.");  
    }


    // 判断当前时间点能不能捐献
    function isInDailyPeriod() internal view returns(bool) {
        // UTC+8
        uint256 utcOffset = 8 hours; 
        // 当前时间戳
        uint256 currentTimestamp = block.timestamp + utcOffset;

        // 计算当天零点时间戳
        uint256 todayZero = currentTimestamp - (currentTimestamp % (1 days));

        // 计算当天的时间窗口
        uint256 startTimestamp = todayZero + STARTHOURS * 1 hours;
        uint256 endTimestamp = todayZero + ENDTHOURS * 1 hours;

        return (currentTimestamp >= startTimestamp && currentTimestamp < endTimestamp);
    }

    

    modifier onlyOwner() {
        require(msg.sender == owner, "Only owner can call this function");
        _;
    }


    event Donation(address indexed _from, uint256 _amount);

    event WithDrawDonations(address indexed _to, uint256 _amount);

}