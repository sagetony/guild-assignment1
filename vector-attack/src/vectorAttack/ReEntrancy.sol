// SPDX-License-Identifier: SEE LICENSE IN LICENSE
pragma solidity 0.8.20;

contract ReEntrancy {
    address payable public owner;

    mapping(address users => uint256 amount) usersAmount;

    constructor() {
        owner = payable(msg.sender);
    }

    function deposit() external payable returns (bool) {
        uint256 amount = msg.value;

        usersAmount[msg.sender] += amount;
        return true;
    }

    function withdraw(uint256 amount) external {
        require(usersAmount[msg.sender] != 0, "Invalid");
        (bool success, ) = payable(msg.sender).call{value: amount}("");
        require(success, "Failed Transaction");
        usersAmount[msg.sender] = 0;
    }
}
