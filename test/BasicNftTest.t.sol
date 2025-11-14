// SPDX-License-Identifier: SEE LICENSE IN LICENSE
pragma solidity ^0.8.18;

import {Test, console} from "forge-std/Test.sol";
import {BasicNFT} from "../src/BasicNFT.sol";
import {DeployBasicNft} from "../script/DeployBasicNft.s.sol";

contract BasicNftTest is Test {
    DeployBasicNft public deployer;
    BasicNFT public basicNft;

    address public USER = makeAddr("user");
    string public constant TOKEN_URI =
        "ipfs://bafybeig37ioir76s7mg5oobetncojcm3c3hxasyd4rvid4jqhy4gkaheg4/?filename=0-PUG.json";

    function setUp() public {
        deployer = new DeployBasicNft();
        basicNft = deployer.run();
    }

    function testNameIsCorrect() public view {
        string memory expectedName = "Dogie";
        string memory name = basicNft.name();
        console.log("Name is:", name);
        assert(keccak256(bytes(name)) == keccak256(bytes(expectedName)));
    }

    function testCanMintAndHaveABalance() public {
        vm.prank(USER);
        basicNft.mintNft(TOKEN_URI);
        assert(basicNft.balanceOf(USER) == 1);
        assert(
            keccak256(bytes(basicNft.tokenURI(0))) ==
                keccak256(bytes(TOKEN_URI))
        );
    }
}
