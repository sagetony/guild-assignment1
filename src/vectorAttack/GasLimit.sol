// SPDX-License-Identifier: MIT
pragma solidity 0.8.20;

contract GasLimit {
    uint[] public data;

    // Function to add elements to the array
    function addData(uint numElements) public {
        for (uint i = 0; i < numElements; i++) {
            data.push(i);
        }
    }

    function clearData() public {
        while (data.length > 0) {
            data.pop();
        }
    }
}
