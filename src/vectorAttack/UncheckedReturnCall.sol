// SPDX-License-Identifier: SEE LICENSE IN LICENSE
pragma solidity 0.8.20;

contract UncheckedReturnCall {
    uint256 public etherLeft;
    mapping(address => uint256) balances;

    function deposit() external payable {
        uint256 amount = msg.value;
        balances[msg.sender] += amount;
        etherLeft += amount;
    }

    function withdraw(uint256 _amount, address _recepicent) public {
        require(balances[msg.sender] >= _amount);
        balances[msg.sender] -= _amount;
        etherLeft -= _amount;
        payable(_recepicent).send(_amount);
    }

    receive() external payable {}
}
