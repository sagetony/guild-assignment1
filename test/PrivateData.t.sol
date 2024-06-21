// SPDX-License-Identifier: SEE LICENSE IN LICENSE
pragma solidity 0.8.20;

import {Test, console} from "forge-std/Test.sol";
import {PrivateData} from "../src/vectorAttack/PrivateData.sol";

contract PrivateDataTest is Test {
    PrivateData privatedata;

    function setUp() external {
        privatedata = new PrivateData();
    }
    // run cast storage contractAddress 2
}
