// SPDX-License-Identifier: MIT
pragma solidity ^0.8.13;

import "forge-std/Script.sol";
import "../src/IsThisCoinDead.sol";

contract Withdraw is Script {
    function setUp() public {}

    function run() public {
        uint256 deployerPrivateKey = vm.envUint("PRIVATE_KEY");
        vm.startBroadcast(deployerPrivateKey);
        IsThisCoinDead coinDead = IsThisCoinDead(
            vm.envAddress("CONTRACT_ADDRESS")
        );
        coinDead.withdraw(vm.envAddress("WITHDRAW_ADDRESS"));
        vm.stopBroadcast();
    }
}