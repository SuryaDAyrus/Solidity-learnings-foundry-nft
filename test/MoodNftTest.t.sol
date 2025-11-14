// SPDX-License-Identifier: SEE LICENSE IN LICENSE
pragma solidity ^0.8.18;

import {Test, console} from "forge-std/Test.sol";
import {MoodNft} from "../src/MoodNft.sol";
import {DeployBasicNft} from "../script/DeployBasicNft.s.sol";

contract MoodNftTest is Test {
    
    address USER = makeAddr("user");
    MoodNft  moodNft;
    string public constant HAPPY_SVG_IMAGE_URI = "data:image/svg+xml;base64,PHN2ZyB4bWxucz0iaHR0cDovL3d3dy53My5vcmcvMjAwMC9zdmciIHZpZXdCb3g9IjAgMCAyMDAgMjAwIj4KICA8Y2lyY2xlIGN4PSIxMDAiIGN5PSIxMDAiIHI9IjgwIiBmaWxsPSJ5ZWxsb3ciIC8+CiAgPGNpcmNsZSBjeD0iNjAiIGN5PSI4MCIgcj0iMTUiIGZpbGw9ImJsYWNrIiAvPgogIDxjaXJjbGUgY3g9IjE0MCIgY3k9IjgwIiByPSIxNSIgZmlsbD0iYmxhY2siIC8+CiAgPGNpcmNsZSBjeD0iNjAiIGN5PSIxMjAiIHI9IjEwIiBmaWxsPSJibGFjayIgLz4KICA8Y2lyY2xlIGN4PSIxNDAiIGN5PSIxMjAiIHI9IjEwIiBmaWxsPSJibGFjayIgLz4KPC9zdmc+";
    string public constant SAD_SVG_IMAGE_URI = "data:image/svg+xml;base64,PHN2ZyB4bWxucz0iaHR0cDovL3d3dy53My5vcmcvMjAwMC9zdmciIHZpZXdCb3g9IjAgMCAyMDAgMjAwIj4KICA8Y2lyY2xlIGN4PSIxMDAiIGN5PSIxMDAiIHI9IjgwIiBmaWxsPSJibHVlIiAvPgogIDxjaXJjbGUgY3g9IjYwIiBjeT0iODAiIHI9IjE1IiBmaWxsPSJ3aGl0ZSIgIC8+CiAgPGNpcmNsZSBjeD0iMTQwIiBjeT0iODAiIHI9IjE1IiBmaWxsPSJ3aGl0ZSIgIC8+CiAgPGNpcmNsZSBjeD0iNjAiIGN5PSIxMjAiIHI9IjEwIiBmaWxsPSJ3aGl0ZSIgIC8+CiAgPGNpcmNsZSBjeD0iMTQwIiBjeT0iMTIwIiByPSIxMCIgZmlsbD0id2hpdGUiIC8+Cjwvc3ZnPg==";

    function setUp() public {
        moodNft = new MoodNft(SAD_SVG_IMAGE_URI, HAPPY_SVG_IMAGE_URI);
    }

    function testTokenURI() public {
        moodNft.mitNft();
        vm.prank(USER);
        string memory tokenUri = moodNft.tokenURI(0);
        console.log("Token URI:", tokenUri);
        // assert(bytes(tokenUri).length > 0);
    }
   }