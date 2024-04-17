// SPDX-License-Identifier: MIT
pragma solidity ^0.8.24;

import {VerifySignature} from "./Verify.sol";

contract ChessStateChannel {
    address public player1;
    address public player2;
    uint256 public wagerAmount;

    struct GameState {
        uint8 seq;
        string board;
        address currentTurn;
        bool gameOver;
    }

    GameState public state;

    uint256 public timeoutInterval;
    uint256 public constant MAX_TIMEOUT = 2 ** 256 - 1;
    // Initially the timeout is some ridiculously high block number.
    // When a timeout is invoked, this value is updated to the
    // current block number + timeoutInterval. When a move is made,
    // Reset this value back to max.
    uint256 public timeout = MAX_TIMEOUT;

    event GameStarted();
    event GameEnded();
    event TimeoutStarted();
    event MoveMade(address player, uint8 seq, string value); // unnecessary

    modifier onlyPlayer() {
        require(
            msg.sender == player1 || msg.sender == player2,
            "Not a player."
        );
        _;
    }

    // SITUATION 1: IDEAL
    // initializeGame is called when two players find each other and set a wager (frontend calls this as a third party)
    //

    // function initializeGame(address player1, address player2, ) public payable

    // {

    // }
}
