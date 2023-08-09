//SPDX-License-Identifier: MIT

pragma solidity^0.8.19;

import {Script} from "../lib/forge-std/src/Script.sol";
import {DevOpsTools} from "../lib/foundry-devops/src/DevOpsTools.sol";
import {BasicNft} from "../src/BasicNft.sol";

contract MintBasicNft is Script {
    string public constant SHIRO = "https://ipfs.io/ipfs/QmSsYRx3LpDAb1GZQm7zZ1AuHZjfbPkD6J7s9r41xu1mf8";

    function run() external {
        address mostRecentDeployed = DevOpsTools.get_most_recent_deployment("BasicNft", block.chainid);
        mintnftOnContract(mostRecentDeployed);
    }
    function mintnftOnContract(address contractAddress) public {
        vm.startBroadcast();
        BasicNft(contractAddress).mintNFT(SHIRO);
        vm.stopBroadcast();
    }
}