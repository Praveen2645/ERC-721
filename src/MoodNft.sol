//SPDX-License-Identifier: MIT

pragma solidity 0.8.19;

import {ERC721} from "../lib/openzeppelin-contracts/contracts/token/ERC721/ERC721.sol";
import {Base64} from "../lib/openzeppelin-contracts/contracts/utils/Base64.sol";

contract MoodNft is ERC721{

    //errors
error MoodNft__CantFlipMoodIfNotowner();

    uint256 private s_tokenCounter;
    string private s_sadSvgImageUri;
    string private s_happySvgImageUri;

    enum Mood {HAPPY,SAD}

    mapping(uint256 => Mood) private s_tokenIdToMood;

    constructor(
        string memory sadSvgImageUri, //this is image uri
        string memory happySvgImageUri
    ) ERC721("Moody NFT","MN"){
        s_tokenCounter =1;
        s_sadSvgImageUri =sadSvgImageUri;
        s_happySvgImageUri =happySvgImageUri;
    }

    function mintNft() public{
        _safeMint(msg.sender,s_tokenCounter);
        s_tokenIdToMood[s_tokenCounter] = Mood.HAPPY; //default minted nft is happy
        s_tokenCounter++;
    }

    function changeMood(uint tokenId) public {
        if(!_isApprovedOrOwner(msg.sender, tokenId)){
            revert MoodNft__CantFlipMoodIfNotowner();
        }
        if(s_tokenIdToMood[tokenId] == Mood.HAPPY){
            s_tokenIdToMood[tokenId] = Mood.SAD;
        } else {
            s_tokenIdToMood[tokenId] == Mood.HAPPY;
        }
    }


    function _baseURI() internal pure override returns(string memory){
        return "data:application/json;base64,";
    }

    function tokenURI(uint256 tokenId) public view override returns(string memory){
        
        string memory imageURI;
        if (s_tokenIdToMood[tokenId]==Mood.HAPPY){
            imageURI = s_happySvgImageUri;
        }else{
            imageURI = s_sadSvgImageUri;
        }

    return
    Base64.encode(
    bytes( 
        abi.encodePacked(
            '{"name":"',
             name(), 
            '", "description":"An NFT that reflects the mood of the owner, 100% on Chain!", ',
            '"attributes": [{"trait_type": "moodiness", "value": 100}], "image":"',
            imageURI,
            '"}'
        )
    )
    );
    }
    }
