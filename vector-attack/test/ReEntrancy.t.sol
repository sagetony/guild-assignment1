// SPDX-License-Identifier: SEE LICENSE IN LICENSE
pragma solidity 0.8.20;

import {Test, console} from "forge-std/Test.sol";
import {ReEntrancy} from "../src/vectorAttack/ReEntrancy.sol";
import {ReentrancyAttack} from "../src/vectorAttack/ReentrancyAttack.sol";

contract ReEntrancyTest is Test {
    ReEntrancy reentrancy;
    ReentrancyAttack reentrancyattack;

    address attacker = address(1);
    address owner = address(2);
    address user = address(3);

    function setUp() external {
        vm.deal(attacker, 10 ether);
        vm.deal(user, 10 ether);

        vm.startPrank(owner);
        reentrancy = new ReEntrancy();
        vm.stopPrank();

        vm.startPrank(attacker);
        reentrancyattack = new ReentrancyAttack((reentrancy));
        (bool success, ) = address(reentrancyattack).call{value: 5 ether}("");
        require(success, "Failed Transactions");
        vm.stopPrank();
    }

    function test_attackreentrancy() external {
        vm.startPrank(user);
        reentrancy.deposit{value: 5 ether}();
        vm.stopPrank();

        vm.startPrank(attacker);

        reentrancyattack.attack(5 ether);
        vm.stopPrank();
    }
}
