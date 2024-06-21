// SPDX-License-Identifier: SEE LICENSE IN LICENSE
pragma solidity 0.8.20;

contract LogicalIssue {
    uint256 public etherLeft;
    mapping(address => uint256) balances;
    address payable public owner;

    constructor() {
        owner = payable(msg.sender);
    }

    modifier onlyOwner() {
        if (msg.sender != owner) revert();
        _;
    }

    function deposit() external payable {
        uint256 amount = msg.value;
        balances[msg.sender] += amount;
        etherLeft += amount;
    }

    function withdraw(uint256 _amount) public {
        require(balances[msg.sender] >= _amount, "Insufficient funds");
        etherLeft -= _amount;
        (bool success, ) = payable(msg.sender).call{value: _amount}("");
        require(success, "Failed Transaction");
    }

    receive() external payable {}
}
