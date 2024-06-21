// SPDX-License-Identifier: MIT
pragma solidity 0.8.20;

contract OverflowUnderflow {
    uint8 public smallNumber;

    constructor() {
        smallNumber = 255;
    }

    function increment() public {
        unchecked {
            smallNumber = smallNumber + 1;
        }
    }

    function decrement() public {
        unchecked {
            smallNumber = smallNumber - 1;
        }
    }
}
