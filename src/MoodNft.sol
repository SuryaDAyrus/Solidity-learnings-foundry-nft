// SPDX-License-Identifier: SEE LICENSE IN LICENSE
pragma solidity ^0.8.18;

import {ERC721} from "@openzeppelin/token/ERC721/ERC721.sol";
import {Base64} from "@openzeppelin/utils/Base64.sol";

contract MoodNft is ERC721 {

    error MoodNft__CanFlipMoodIfNotOwner();
    // MoodNft contract code goes here
    enum Mood {
        HAPPY,
        SAD
    }
    mapping(uint256 => Mood) private s_tokenIdMood;
    uint256 private s_tokenCounter;
    string private s_sadSvgImageUri;
    string private s_happySvgImageUri;

    constructor(
        string memory sadSvgImageUri,
        string memory happySvgImageUri
    ) ERC721("Mood NFT", "MN") {
        s_tokenCounter = 0;
        s_sadSvgImageUri = sadSvgImageUri;
        s_happySvgImageUri = happySvgImageUri;
    }

    function mitNft() public {
        _safeMint(msg.sender, s_tokenCounter);
        s_tokenCounter++;
    }

    function _baseURI() internal pure override returns (string memory) {
        return "data:application/json;base64,";
    }


    function flipMood(uint256 tokenId) public {
      if (!_isApprovedOrOwner(msg.sender, tokenId)) {
          revert MoodNft__CanFlipMoodIfNotOwner();
      }
      if (s_tokenIdMood[tokenId] == Mood.HAPPY) {
          s_tokenIdMood[tokenId] = Mood.SAD;
      } else {
          s_tokenIdMood[tokenId] = Mood.HAPPY;
      }  
    }

    function tokenURI(
        uint256 tokenId
    ) public view override returns (string memory) {
        // Logic to return token URI based on mood
        string memory imageURI;
        if (s_tokenIdMood[tokenId] == Mood.HAPPY) {
            imageURI = s_happySvgImageUri;
        } else {
            imageURI = s_sadSvgImageUri;
        }
        return
            string(
                abi.encodePacked(
                    _baseURI(),
                    Base64.encode(
                        bytes( // bytes casting actually unnecessary as 'abi.encodePacked()' returns a bytes
                            abi.encodePacked(
                                '{"name":"',
                                name(), // You can add whatever name here
                                '", "description":"An NFT that reflects the mood of the owner, 100% on Chain!", ',
                                '"attributes": [{"trait_type": "moodiness", "value": 100}], "image":"',
                                imageURI,
                                '"}'
                            )
                        )
                    )
                )
            );
    }
}
