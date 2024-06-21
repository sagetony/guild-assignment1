// SPDX-License-Identifier: MIT
pragma solidity 0.8.20;

import {Test, console} from "forge-std/Test.sol";

contract BadRandomness {
    uint256 public randomNumber;
    // Event to log the random number
    event RandomNumberGenerated(uint256 randomNumber);

    // Function to generate a random number
    function getRandomNumber() public returns (uint256) {
        // BAD SOURCE OF RANDOMNESS
        randomNumber = uint256(
            keccak256(abi.encodePacked(block.timestamp, msg.sender))
        );

        emit RandomNumberGenerated(randomNumber);
        return randomNumber;
    }
}
