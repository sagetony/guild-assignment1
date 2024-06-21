// SPDX-License-Identifier: SEE LICENSE IN LICENSE
pragma solidity 0.8.20;

import {Test, console} from "forge-std/Test.sol";
import {PrecisionLoss} from "../src/vectorAttack/PrecisionLoss.sol";

contract PrecisionLossTest is Test {
    PrecisionLoss precisionloss;
    address user = address(1);
    address userTwo = address(2);

    function setUp() external {
        vm.deal(user, 10 ether);
        vm.deal(userTwo, 10 ether);

        precisionloss = new PrecisionLoss();
    }

    function test_precisionloss() external {
        vm.startPrank(userTwo);
        precisionloss.stake{value: 10 ether}();
        vm.stopPrank();
        vm.startPrank(user);
        precisionloss.stake{value: 10 ether}();
        precisionloss.withdraw(10 ether);
        if (user.balance > 10 ether) revert();
        vm.stopPrank();
    }
}
