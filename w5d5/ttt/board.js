function Board () {
  this.grid = [[], [], []];
  this.winner = undefined;
  console.log(JSON.stringify(this.grid));
}

Board.prototype.won = function() {
  // console.log(this.checkRows())
  // console.log(this.checkColumns() || this.checkDiagonals());
  return this.checkRows() || this.checkColumns() || this.checkDiagonals();
};

Board.prototype.checkRows = function() {
  this.grid.forEach(function (row) {
    if (row == ['x', 'x', 'x']) { // wwwhhssttt
      this.winner = 'x';
      return true;
    } else if (row == ['o', 'o', 'o']) {
      this.winner = 'o';
      return true;
    }
  });
  // return false;
};

Board.prototype.checkColumns = function() {
  for (var i=0; i < 3; i++) {
    var column = [];
    for (var j=0; j < 3; j++) {
      column.push(this.grid[j][i]);
    }
    if (column === ['x', 'x', 'x']) {
      this.winner = 'x';
      return true;
    } else if (column === ['o', 'o', 'o']) {
      this.winner = 'o';
      return true;
    }
  }
  // return false;
};

Board.prototype.checkDiagonals = function() {
  var diagonalOne = [];
  for (var i=0; i < 3; i++) {
    diagonalOne.push(this.grid[i][i]);
  }
  var diagonalTwo = [this.grid[2][0],
                     this.grid[1][1],
                     this.grid[0][2]];

  var that = this;
  [diagonalOne, diagonalTwo].forEach(function (element) {
    switch (element) {
      case ['x', 'x', 'x']:
        that.winner = 'x';
        return true;
      case ['o', 'o', 'o']:
        that.winner = 'o';
        return true;
    }
  });
  // return false;
};

Board.prototype.winner = function() {
  if (this.winner) {
    return this.winner;
  }
};

Board.prototype.empty = function(pos) {
  return !this.grid[pos[0]][pos[1]];
};

Board.prototype.placeMark = function(pos, mark) {
  if (0 <= pos[0] <= 2 && 0 <= pos[1] <= 2 &&
      this.empty(pos)) {
    this.grid[pos[0]][pos[1]] = mark;
    console.log("WAT");
    return true;
  } else {
    console.log("invalid position");
    return false;
  }
};

module.exports = Board;
