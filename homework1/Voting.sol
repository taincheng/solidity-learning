// SPDX-License-Identifier: MIT
pragma solidity ^0.8;

// 创建一个名为Voting的合约，包含以下功能：
// 一个mapping来存储候选人的得票数
// 一个vote函数，允许用户投票给某个候选人
// 一个getVotes函数，返回某个候选人的得票数
// 一个resetVotes函数，重置所有候选人的得票数

contract Voting {

    // 计票
    mapping(string candidate => uint256 votes) public votesMapping;
    // 候选人列表
    string[] public candidates;

    // 判断候选人是否已经加入
    function candidatesExist(string memory _candidate) internal view returns (bool) {
        for (uint256 i = 0; i < candidates.length; i++) {
            if (keccak256(bytes(candidates[i])) == keccak256(bytes(_candidate))) {
                return true;
            }
        }
        return false;
    }

    // 投票给候选人
    function vote(string memory _candidate) external {
        votesMapping[_candidate] += 1;
        // 加入列表
        if (!candidatesExist(_candidate)) {
            candidates.push(_candidate);
        }
    }

    // 获取候选人的得票数
    function getVotes(string memory _candidate) external view returns (uint256) {
        return votesMapping[_candidate];
    }

    // 重置所有候选人的票数
    function resetVotes() external {
        for (uint i = 0; i < candidates.length; i ++) {
            delete votesMapping[candidates[i]];
        }
    }

}