var TicTacToe = require('./ttt');

var Board = TicTacToe.Board;
var Game = TicTacToe.Game;

var readline = require('readline');

var reader = readline.createInterface({
  input: process.stdin,
  output: process.stdout
});

var game = new Game(reader, 'x', 'o');
game.play(function (winner) {
  console.log(winner + ' is the winner!');
});
