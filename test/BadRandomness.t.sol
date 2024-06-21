// SPDX-License-Identifier: SEE LICENSE IN LICENSE
pragma solidity 0.8.20;

import {Test, console} from "forge-std/Test.sol";
import {BadRandomness} from "../src/vectorAttack/BadRandomness.sol";

contract BaddRandomnessTest is Test {
    BadRandomness badrandomness;
    address userOne = address(1);

    function setUp() external {
        badrandomness = new BadRandomness();
    }

    function test_getRandomNumber() external {
        vm.startPrank(userOne);
        vm.warp(184343434);
        badrandomness.getRandomNumber();
        uint32 blockTime = 184343434;
        uint256 randomNo = uint256(
            keccak256(abi.encodePacked(blockTime, userOne))
        );

        console.log(blockTime, userOne, randomNo);
        // if (badrandomness.randomNumber() != randomNo) revert();
        vm.stopPrank();
    }
}
