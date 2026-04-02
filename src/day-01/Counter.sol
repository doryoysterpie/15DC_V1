// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

contract Counter {
    uint256 private count;

    // Returns the current count
    function getCount() public view returns (uint256) {
        return count;
    }

    // Increases the count by 1
    function increment() public {
        count += 1;
    }

    // Decreases the count by 1
    function decrement() public {
        require(count > 0, "Counter: cannot go below zero");
        count -= 1;
    }
}