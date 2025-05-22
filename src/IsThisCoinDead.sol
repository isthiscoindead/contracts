// SPDX-License-Identifier: MIT
pragma solidity ^0.8.13;

contract IsThisCoinDead {
    mapping(bytes32 => uint256) public totalVoteDead;
    mapping(bytes32 => uint256) public totalVoteAlive;
}