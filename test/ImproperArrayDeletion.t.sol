// SPDX-License-Identifier: SEE LICENSE IN LICENSE
pragma solidity 0.8.20;

import {Test, console} from "forge-std/Test.sol";
import {ImproperArrayDeletion} from "../src/vectorAttack/ImproperArrayDeletion.sol";

contract ImproperArrayDeletionTest is Test {
    ImproperArrayDeletion improperarraydeletion;

    function setUp() external {
        improperarraydeletion = new ImproperArrayDeletion();
    }

    function test_addDataInArray() external {
        improperarraydeletion.addDataInArray(4);
        uint256 arrayLengthBefore = (improperarraydeletion.getDataLength());

        improperarraydeletion.clearData();
        uint256 arrayLengthAfter = (improperarraydeletion.getDataLength());
        if (arrayLengthAfter != arrayLengthBefore) revert();
    }
}
