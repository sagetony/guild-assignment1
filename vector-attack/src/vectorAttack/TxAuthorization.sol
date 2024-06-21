// SPDX-License-Identifier: SEE LICENSE IN LICENSE
pragma solidity 0.8.20;

contract TxAuthorization {
    address payable public owner;

    constructor() {
        owner = payable(msg.sender);
    }

    function withdraw() external {
        require(tx.origin == owner, "Not Authorized");

        (bool success, ) = payable(owner).call{value: address(this).balance}(
            ""
        );
        require(success, "Failed Transaction");
    }

    receive() external payable {}
}
