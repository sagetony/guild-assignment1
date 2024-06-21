// SPDX-License-Identifier: SEE LICENSE IN LICENSE
pragma solidity 0.8.20;

import {Test, console} from "forge-std/Test.sol";
import {GasLimit} from "../src/vectorAttack/GasLimit.sol";

contract GasLimitTest is Test {
    GasLimit gaslimit;

    function setUp() external {
        gaslimit = new GasLimit();
    }

    function test_addData() external {
        gaslimit.addData(20000000);
        gaslimit.clearData();
    }
}
