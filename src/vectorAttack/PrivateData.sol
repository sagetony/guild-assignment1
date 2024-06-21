// SPDX-License-Identifier: MIT
pragma solidity 0.8.20;

contract PrivateData {
    error PasswordStore__NotOwner();

    address private s_owner;
    string private s_password;

    event SetNetPassword();

    constructor() {
        s_owner = msg.sender;
    }

    /*
     * @notice This function allows only the owner to set a new password.
     * @param newPassword The new password to set.
     */

    function setPassword(string memory newPassword) external {
        s_password = newPassword;
        emit SetNetPassword();
    }
}
