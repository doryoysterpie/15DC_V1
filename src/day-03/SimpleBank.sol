// SPDX-License-Identifier: MIT
pragma solidity ^0.8.13;

contract SimpleBank {
    // STATE VARIABLES (stored on blockchain)
    mapping(address => uint256) private balances;

    // EVENTS (logs for tracking what happened)
    event Deposit(address indexed user, uint256 amount);
    event Withdrawal(address indexed user, uint256 amount);

    function deposit() public payable {
        require(msg.value > 0, "Must deposit something");
        balances[msg.sender] += msg.value;
        emit Deposit(msg.sender, msg.value);
    }

    function withdraw(uint256 amount) public {
        require(amount > 0, "Must withdraw something");
        require(balances[msg.sender] >= amount, "Insufficient balance");
        balances[msg.sender] -= amount;
       (bool success, ) = msg.sender.call{value: amount}("");
        require(success, "Transfer failed");
        emit Withdrawal(msg.sender, amount);
    }

    function getBalance(address user) public view returns (uint256) {
        return balances[user];
    }

    function getMyBalance() public view returns (uint256) {
        return balances[msg.sender];
    }
}