// SPDX-License-Identifier: SEE LICENSE IN LICENSE
pragma solidity 0.8.20;

import {Test, console} from "forge-std/Test.sol";
import {CodeWithNoEffect} from "../src/vectorAttack/CodeWithNoEffect.sol";

contract CodeWithNoEffectTest is Test {
    CodeWithNoEffect codewithnoeffect;

    address user = address(1);

    function setUp() external {
        vm.deal(user, 10 ether);

        codewithnoeffect = new CodeWithNoEffect();
    }

    function test_pay() external {
        vm.startPrank((user));
        codewithnoeffect.deposit{value: 5 ether}();
        vm.expectRevert();
        codewithnoeffect.withdraw(5 ether);
        vm.stopPrank();
    }
}
