// SPDX-License-Identifier: MIT
pragma solidity ^0.8.13;

import "forge-std/Test.sol";
import "../src/day-03/SimpleBank.sol";

contract SimpleBankTest is Test {
    SimpleBank public bank;
    address public user1;
    address public user2;

    function setUp() public {
        bank = new SimpleBank();
        user1 = address(0x1);
        user2 = address(0x2);

        // give test users some ETH
        vm.deal(user1, 100 ether);
        vm.deal(user2, 100 ether);
    }

    function testDeposit() public {
        vm.prank(user1);
        bank.deposit{value: 10 ether}();
        assertEq(bank.getBalance(user1), 10 ether);
    }

    function testWithdraw() public {
        // first deposit
        vm.prank(user1);
        bank.deposit{value: 10 ether}();

        // then withdraw half
        vm.prank(user1);
        bank.withdraw(5 ether);

        // should have 5 ETH left in bank
        assertEq(bank.getBalance(user1), 5 ether);

        // user1's wallet should have increased by 5 ETH
        // (started with 100, deposited 10, withdrew 5 = 95)
        assertEq(user1.balance, 95 ether);
    }

    function testCannotWithdrawMoreThanBalance() public {
        vm.prank(user1);
        bank.deposit{value: 10 ether}();

        vm.prank(user1);
        vm.expectRevert("Insufficient balance");
        bank.withdraw(20 ether);
    }

    function testUsersHaveSeparateBalances() public {
        vm.prank(user1);
        bank.deposit{value: 10 ether}();

        vm.prank(user2);
        bank.deposit{value: 5 ether}();

        assertEq(bank.getBalance(user1), 10 ether);
        assertEq(bank.getBalance(user2), 5 ether);

        // user2 can't withdraw user1's money
        vm.prank(user2);
        vm.expectRevert("Insufficient balance");
        bank.withdraw(10 ether);
    }
}