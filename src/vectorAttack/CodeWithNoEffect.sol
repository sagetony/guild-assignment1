// SPDX-License-Identifier: SEE LICENSE IN LICENSE
pragma solidity 0.8.20;

contract CodeWithNoEffect {
    uint256 public etherLeft;
    mapping(address => uint256) balances;

    function deposit() external payable {
        uint256 amount = msg.value;
        // @audit
        balances[msg.sender] == amount;
        etherLeft += amount;
    }

    function withdraw(uint256 _amount) public {
        require(balances[msg.sender] >= _amount, "No enough funds");
        balances[msg.sender] -= _amount;
        etherLeft -= _amount;
        bool success = payable(msg.sender).send(_amount);
        if (!success) revert();
    }

    receive() external payable {}
}
