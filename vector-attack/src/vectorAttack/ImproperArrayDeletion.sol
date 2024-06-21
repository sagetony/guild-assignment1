// SPDX-License-Identifier: MIT
pragma solidity 0.8.20;

contract ImproperArrayDeletion {
    uint256[] public data;

    function addDataInArray(uint256 numElements) public {
        for (uint256 i = 0; i < numElements; i++) {
            data.push(i);
        }
    }

    function clearData() public {
        for (uint256 i = 0; i < data.length; i++) {
            data[i] = 0;
        }
    }

    function getDataLength() public view returns (uint256) {
        return data.length;
    }

    function getData(uint256 index) public view returns (uint256) {
        require(index < data.length, "Index out of bounds");
        return data[index];
    }
}
