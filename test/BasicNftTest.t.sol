//SPDX-License-Identifier: MIT

pragma solidity^0.8.19;

import {Test} from "../lib/forge-std/src/Test.sol";
import {DeployBasicNft} from "../script/DeployBasicNft.s.sol";
import {BasicNft} from "../src/BasicNft.sol";

contract BasicNftTest is Test {
    DeployBasicNft public deployer;
    BasicNft public basicNft;
    address public USER = makeAddr("user");
    string public constant SHIRO = "ipfs://bafybeig37ioir76s7mg5oobetncojcm3c3hxasyd4rvid4jqhy4gkaheg4/?filename=0-PUG.json";

    function setUp() public {
      deployer = new DeployBasicNft();
      basicNft = deployer.run();  
    }

    function testNameIsCorrect() public view {
        string memory expectedName = "SHIRO";
        string memory actualName = basicNft.name();

        assert(
            keccak256(abi.encodePacked(expectedName))==
                keccak256(abi.encodePacked(actualName))
        );
    }
     function testCanMintAndHaveABalance() public {
        vm.prank(USER);
        basicNft.mintNFT(SHIRO);

        assert(basicNft.balanceOf(USER)== 1);
        assert(
            keccak256(abi.encodePacked(SHIRO))==
                keccak256(abi.encodePacked(basicNft.tokenURI(0)))
        );    
     }
}