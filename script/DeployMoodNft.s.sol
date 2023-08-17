// SPDX-License-Identifier: MIT
pragma solidity 0.8.19;

import {Script, console} from "forge-std/Script.sol";
import {MoodNft} from "../src/MoodNft.sol";
import {Base64} from "@openzeppelin/contracts/utils/Base64.sol";
import {console} from "forge-std/console.sol";

contract DeployMoodNft is Script {
    uint256 public DEFAULT_ANVIL_PRIVATE_KEY =
        0xac0974bec39a17e36ba4a6b4d238ff944bacb478cbed5efcae784d7bf4f2ff80;
    uint256 public deployerKey;

    function run() external returns (MoodNft) {
        if (block.chainid == 31337) {
            deployerKey = DEFAULT_ANVIL_PRIVATE_KEY;
        } else {
            deployerKey = vm.envUint("PRIVATE_KEY");
        }

        string memory sadSvg = vm.readFile("../");
        string memory happySvg = vm.readFile("");

        vm.startBroadcast(deployerKey);
        MoodNft moodNft = new MoodNft(
            svgToImageURI(sadSvg),
            svgToImageURI(happySvg)
        );
        vm.stopBroadcast();
        return moodNft;
    }

    //this function gives svg code an uri
    function svgToImageURI( 
        string memory svg
    ) public pure returns (string memory) {
        // example: take input
        // '<svg width="500" height="500" viewBox="0 0 285 350" fill="none" xmlns="http://www.w3.org/2000/svg"><path fill="black" d="M150,0,L75,200,L225,200,Z"></path></svg>'
        // would return "" string
        string memory baseURL = "data:image/svg+xml;base64,";//prefix of the uri
        string memory svgBase64Encoded = Base64.encode(
            bytes(string(abi.encodePacked(svg)))//encoding svg >>converting to string>>and then encoding it
        );
        return string(abi.encodePacked(baseURL, svgBase64Encoded));//encodePacked or concate
    }
}