// SPDX-License-Identifier: MIT
pragma solidity ^0.8.24;

import {VerifySignature} from "./Verify.sol";

contract ChessGame {
    enum GameState {
        WaitingForOpponent,
        Active,
        Completed
    }
    enum GameResult {
        Ongoing,
        Draw,
        Player1Wins,
        Player2Wins
    }

    struct Game {
        address player1;
        address player2;
        uint256 betAmount;
        GameState state;
        GameResult result;
    }

    mapping(uint256 => Game) public games;
    uint256 public totalGames = 0;
    uint256 public minimumBetAmount = 0.001 ether;
    address public arbitrator;

    // Event declarations
    event GameCreated(uint gameId, address creator, uint256 betAmount);
    event GameStarted(uint gameId, address opponent);
    event GameEnded(uint gameId, GameResult result);

    // Modifiers
    modifier inState(uint _gameId, GameState _state) {
        require(games[_gameId].state == _state, "Invalid game state.");
        _;
    }

    modifier requiresMinimumBet(uint256 _betAmount) {
        require(
            _betAmount >= minimumBetAmount,
            "Bet does not meet the minimum requirement."
        );
        _;
    }

    modifier onlyArbitrator() {
        require(
            msg.sender == arbitrator,
            "Only the arbitrator can call this function."
        );
        _;
    }

    // functions
    function createGame()
        public
        payable
        requiresMinimumBet(msg.value)
        returns (uint gameId)
    {
        gameId = totalGames;
        games[totalGames] = Game({
            player1: msg.sender,
            player2: address(0), // No opponent yet
            betAmount: msg.value,
            state: GameState.WaitingForOpponent,
            result: GameResult.Ongoing
        });
        totalGames += 1;

        emit GameCreated(gameId, msg.sender, msg.value);
        return gameId;
    }

    function joinGame(
        uint _gameId
    ) public payable inState(_gameId, GameState.WaitingForOpponent) {
        Game storage game = games[_gameId];
        require(msg.value == game.betAmount, "Bet amount does not match.");

        game.player2 = msg.sender;
        game.state = GameState.Active;

        emit GameStarted(_gameId, msg.sender);
    }

    function endGame(
        uint _gameId,
        GameResult _result
    ) public inState(_gameId, GameState.Active) {
        Game storage game = games[_gameId];

        if (_result == GameResult.Player1Wins) {
            require(
                msg.sender == game.player1,
                "Only the winner can end the game."
            );
        } else if (_result == GameResult.Player2Wins) {
            require(
                msg.sender == game.player2,
                "Only the winner can end the game."
            );
        }

        game.result = _result;
        game.state = GameState.Completed;

        if (_result == GameResult.Player1Wins) {
            payable(game.player1).transfer(game.betAmount * 2);
        } else if (_result == GameResult.Player2Wins) {
            payable(game.player2).transfer(game.betAmount * 2);
        } else if (_result == GameResult.Draw) {
            payable(game.player1).transfer(game.betAmount);
            payable(game.player2).transfer(game.betAmount);
        }

        emit GameEnded(_gameId, _result);
    }

    // TODO: Use Oracle + Study logic
    function challenge(uint _gameId, address playerKey) public {}
}
