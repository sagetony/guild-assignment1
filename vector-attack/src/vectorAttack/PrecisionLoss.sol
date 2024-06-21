// SPDX-License-Identifier: MIT
pragma solidity 0.8.20;
import {Test, console} from "forge-std/Test.sol";

contract PrecisionLoss {
    uint256 public etherLeft;
    mapping(address => uint256) balances;
    uint256 APY = 10;

    function stake() external payable {
        uint256 amount = msg.value;
        balances[msg.sender] += amount;

        etherLeft += amount;
    }

    function calculatereward() public view returns (uint) {
        uint256 amountStakedPerUser = balances[msg.sender];

        return (((amountStakedPerUser / etherLeft) * (APY / 100)));
    }

    function withdraw(uint256 _amount) public {
        require(balances[msg.sender] >= _amount, "No enough funds");
        uint256 amountToSend = calculatereward() + _amount;
        balances[msg.sender] -= _amount;
        etherLeft -= _amount;
        (bool success, ) = payable(msg.sender).call{value: amountToSend}("");
        if (!success) revert();
    }

    receive() external payable {}
}
