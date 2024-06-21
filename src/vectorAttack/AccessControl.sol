// SPDX-License-Identifier: SEE LICENSE IN LICENSE
pragma solidity 0.8.20;

// @notice This contract is used to donate funds

contract AccessControl {
    address payable public NGO;
    uint256 public totalAmountContributed;

    mapping(address donators => uint256 amount) contributionPerUsers;

    event Donate(address indexed user, uint256 indexed amount);

    constructor() {
        NGO = payable(msg.sender);
    }

    function donate() external payable returns (bool) {
        uint256 amount = msg.value;

        totalAmountContributed += amount;
        contributionPerUsers[msg.sender] += amount;

        emit Donate(msg.sender, amount);
        return true;
    }

    function withdraw(address payable community, uint256 amount) external {
        require(amount < address(this).balance, "Insufficient funds");
        (bool success, ) = community.call{value: amount}("");
        require(success, "Failed Transaction");
    }

    receive() external payable {}
}
