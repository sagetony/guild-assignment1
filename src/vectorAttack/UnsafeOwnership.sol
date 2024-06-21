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

    function withdraw() public onlyOwner {
        require(address(this).balance >= etherLeft, "Invalid");
        (bool success, ) = owner.call{value: address(this).balance}("");
        require(success, "Failed Transaction");
    }

    function transferOwnership(address newOwner) public onlyOwner {
        require(
            newOwner != address(0),
            "Ownable: new owner is the zero address"
        );
        owner = payable(newOwner);
    }

    receive() external payable {}
}
