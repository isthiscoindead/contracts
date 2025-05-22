// SPDX-License-Identifier: MIT
pragma solidity ^0.8.13;

import "forge-std/Script.sol";
import "../src/IsThisCoinDead.sol";

contract Deploy is Script {
    function setUp() public {}

    function run() public {
        uint256 deployerPrivateKey = vm.envUint("PRIVATE_KEY");
        vm.startBroadcast(deployerPrivateKey);
        address deployer = vm.addr(deployerPrivateKey);
        console.log("Deployer address: ", deployer);

        IsThisCoinDead coinDead = new IsThisCoinDead(0.0001 ether);
        console.log("IsThisCoinDead deployed at: ", address(coinDead));

        vm.stopBroadcast();
    }
}