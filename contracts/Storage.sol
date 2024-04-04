// SPDX-License-Identifier: MIT
pragma solidity ^0.8.24;

// Uncomment this line to use console.log
import "hardhat/console.sol";

contract Storage {
    address owner;
    event EtherStored(address sender, uint amount);
    event EtherWithdrawn(address sender, uint amount);
    event Stolen();

    mapping(address => uint) public balances;

    modifier onlyOwner() {
        require(msg.sender == owner);
        _;
    }

    constructor() {
        owner = msg.sender;
    }

    function storeEther() external payable {
        balances[msg.sender] += msg.value;
        emit EtherStored(msg.sender, msg.value);
    }

    function withdrawEther(uint amount) external {
        require(amount <= balances[msg.sender], "Not enough balance");

        (bool sent, ) = msg.sender.call{value: amount}("");
        require(sent, "Failed to withdraw Ether");

        balances[msg.sender] -= amount;

        emit EtherWithdrawn(msg.sender, amount);
    }

    function checkBalance() external view returns (uint) {
        return balances[msg.sender];
    }
}
