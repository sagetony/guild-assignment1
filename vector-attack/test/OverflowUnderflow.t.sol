// SPDX-License-Identifier: SEE LICENSE IN LICENSE
pragma solidity 0.8.20;

import {Test, console} from "forge-std/Test.sol";
import {OverflowUnderflow} from "../src/vectorAttack/OverflowUnderflow.sol";

contract OverflowUnderflowTest is Test {
    OverflowUnderflow overflowunderflow;

    function setUp() external {
        overflowunderflow = new OverflowUnderflow();
    }

    function test_overflowunderflow() external {
        overflowunderflow.increment();
        if (overflowunderflow.smallNumber() != 0) revert();
    }
}
