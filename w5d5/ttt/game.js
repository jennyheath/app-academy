var Board = require('./board');


function Game(reader, player1, player2) {
  this.reader = reader;
  this.player1 = player1;
  this.player2 = player2;
  this.currentPlayer = player1;
  this.board = new Board();
}

Game.prototype.play = function (completionCallback) {
  var that = this;
  console.log(JSON.stringify(this.board));
  this.reader.question("It is " + this.currentPlayer +
      "'s turn. What row would you like to mark?", function (x) {
    that.reader.question("What column would you like to mark?", function (y) {
      var row = parseInt(x);
      var column = parseInt(y);
      if (that.board.placeMark([row, column], that.currentPlayer)) {
        if (that.board.won()) {
          completionCallback(that.board.winner());
        } else {
          that.currentPlayer = (that.currentPlayer === 'x' ? 'o' : 'x');
          that.play(completionCallback);
        }
      } else {
        console.log("invalid move");
        that.play(completionCallback);
      }
    });
  });
};

module.exports = Game;


//run(completionCallback)
