// SPDX-License-Identifier: MIT
pragma solidity ^0.8.24;

// Uncomment this line to use console.log
import "hardhat/console.sol";

contract Storage {
    address owner;
    event EtherStored();
    event receivedEther();

    mapping(address => uint) balances;

    modifier onlyOwner() {
        require(msg.sender == owner);
        _;
    }

    constructor() {
        owner = msg.sender;
    }

    function storeEther() public payable {
        balances[msg.sender] += msg.value;
        emit EtherStored();
    }

    function receiveEther(uint8 amount) public {

        require(amount <= balances[msg.sender], "Not enough balance");
        
        

        emit receivedEther();
    }
}
