// SPDX-License-Identifier: SEE LICENSE IN LICENSE
pragma solidity 0.8.20;

import {Test, console} from "forge-std/Test.sol";
import {TxAuthorization} from "../src/vectorAttack/TxAuthorization.sol";

contract TxAuthorizationTest is Test {
    TxAuthorization txauthorization;

    address Richkid = address(1);
    address owner = address(2);

    function setUp() external {
        vm.deal(Richkid, 10 ether);

        vm.startPrank(owner);
        txauthorization = new TxAuthorization();
        vm.stopPrank();

        vm.startPrank(Richkid);
        (bool success, ) = payable(address(txauthorization)).call{
            value: 10 ether
        }("");
        require(success, "Failed Transaction");
        vm.stopPrank();
    }

    function test_withdraw() external {
        vm.startPrank(owner);
        vm.expectRevert("Not Authorized");
        txauthorization.withdraw();
        vm.stopPrank();
    }
}
