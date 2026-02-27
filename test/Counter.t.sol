// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import {Test} from "forge-std/Test.sol";
import {Counter} from "../src/Counter.sol";

contract CounterTest is Test {
    Counter public counter;

    function setUp() public {
        counter = new Counter(); // starts at 0, no need for setNumber
    }

    function test_Increment() public {
        counter.increment();
        assertEq(counter.getCount(), 1); // use getCount() instead of number()
    }

    function test_IncrementThenDecrement() public {
        counter.increment();
        counter.decrement();
        assertEq(counter.getCount(), 0);
    }

    function test_CannotDecrementBelowZero() public {
        vm.expectRevert("Counter: cannot go below zero");
        counter.decrement();
    }
}