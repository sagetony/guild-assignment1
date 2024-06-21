// SPDX-License-Identifier: SEE LICENSE IN LICENSE
pragma solidity 0.8.20;

import {Test, console} from "forge-std/Test.sol";
import {UncheckedReturnCall} from "../src/vectorAttack/UncheckedReturnCall.sol";

contract UncheckedReturnCallTest is Test {
    UncheckedReturnCall uncheckedreturncall;
    Attacker attacker;

    address user = address(1);

    function setUp() external {
        vm.deal(user, 10 ether);

        uncheckedreturncall = new UncheckedReturnCall();
        attacker = new Attacker();
    }

    function test_play() external {
        vm.startPrank((user));
        uncheckedreturncall.deposit{value: 5 ether}();
        uncheckedreturncall.withdraw(5 ether, address(attacker));
        vm.stopPrank();

        if (address(attacker).balance > 0) revert();
    }
}

contract Attacker {}
