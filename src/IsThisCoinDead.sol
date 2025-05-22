// SPDX-License-Identifier: MIT
pragma solidity ^0.8.13;
import "openzeppelin/access/Ownable.sol";

contract IsThisCoinDead is Ownable {
    uint256 public voteFee;

    mapping(bytes32 => uint256) public totalVoteDead;
    mapping(bytes32 => uint256) public totalVoteAlive;

    event VoteDead(address voter, bytes32 coin);
    event VoteAlive(address voter, bytes32 coin);

    constructor(uint256 _voteFee) Ownable(msg.sender) {
        voteFee = _voteFee;
    }

    function voteDead(bytes32 coin) external payable {
        require(msg.value == voteFee, "Incorrect fee");
        totalVoteDead[coin] += 1;

        emit VoteDead(msg.sender, coin);
    }

    function voteAlive(bytes32 coin) external payable {
        require(msg.value == voteFee, "Incorrect fee");
        totalVoteAlive[coin] += 1;

        emit VoteAlive(msg.sender, coin);
    }

    function isThisCoinDead(bytes32 coin) external view returns (uint256, uint256) {
        return (totalVoteDead[coin], totalVoteAlive[coin]);
    }

    function withdraw(address receiver) external onlyOwner {
        uint256 balance = address(this).balance;
        require(balance > 0, "No balance to withdraw");
        payable(receiver).transfer(balance);
    }
}