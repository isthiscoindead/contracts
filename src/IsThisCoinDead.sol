// SPDX-License-Identifier: MIT
pragma solidity 0.8.28;

import "openzeppelin/access/Ownable.sol";

contract IsThisCoinDead is Ownable {
    uint256 public voteFee;

    mapping(bytes32 => uint256) public totalVoteDead;
    mapping(bytes32 => uint256) public totalVoteAlive;

    event VoteFeeChanged(uint256 newVoteFee);
    event VoteDead(address voter, bytes32 coin);
    event VoteAlive(address voter, bytes32 coin);

    constructor(uint256 _voteFee) Ownable(msg.sender) {
        voteFee = _voteFee;
    }

    function setVoteFee(uint256 _voteFee) external onlyOwner {
        voteFee = _voteFee;
        emit VoteFeeChanged(_voteFee);
    }

    function voteDead(bytes32 _coin) external payable {
        require(msg.value == voteFee, "Incorrect fee");
        totalVoteDead[_coin] += 1;

        emit VoteDead(msg.sender, _coin);
    }

    function voteAlive(bytes32 _coin) external payable {
        require(msg.value == voteFee, "Incorrect fee");
        totalVoteAlive[_coin] += 1;

        emit VoteAlive(msg.sender, _coin);
    }

    function withdraw(address _receiver) external onlyOwner {
        uint256 balance = address(this).balance;
        require(balance > 0, "No balance to withdraw");
        payable(_receiver).transfer(balance);
    }

    function isThisCoinDead(bytes32 _coin) external view returns (uint256, uint256) {
        return (totalVoteDead[_coin], totalVoteAlive[_coin]);
    }
}
