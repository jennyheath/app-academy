var readline = require('readline');

var reader = readline.createInterface({
  input: process.stdin,
  output: process.stdout
});

function HanoiGame() {
  this.stacks = [[3, 2, 1], [], []];
}

HanoiGame.prototype.isWon = function() {
  if (this.stacks[0].length === 0 &&
      (this.stacks[1].length === 0 || this.stacks[2].length === 0)) {
    return true;
  } else {
    return false;
  }
};

HanoiGame.prototype.isValidMove = function(startTowerIdx, endTowerIdx) {
  // console.log(this.stacks);
  if (this.stacks[startTowerIdx].length === 0) {
    return false;
  } else {
    if (this.stacks[endTowerIdx].length === 0) {
      return true;
    } else {
      var startTop = this.stacks[startTowerIdx].slice(-1);
      var endTop = this.stacks[endTowerIdx].slice(-1);

      if (startTop > endTop) {
        return false;
      } else if (endTop > startTop) {
        return true;
      }
    }
  }
};

HanoiGame.prototype.move = function(startTowerIdx, endTowerIdx) {
  if (this.isValidMove(startTowerIdx, endTowerIdx)) {
    this.stacks[endTowerIdx].push(this.stacks[startTowerIdx].pop());
    return true;
  } else {
    return false;
  }
};

HanoiGame.prototype.print = function() {
  console.log(JSON.stringify(this.stacks));
};

HanoiGame.prototype.promptMove = function(callback) {
  this.print();
  reader.question("What tower would you like to move from?", function (start) {
    reader.question("What tower would you like to move to?", function (end) {
      var startTowerIdx = parseInt(start);
      var endTowerIdx = parseInt(end);

      callback(startTowerIdx, endTowerIdx);
    });
  });
};

HanoiGame.prototype.run = function (completionCallback) {
  var that = this;
  this.promptMove(function (startTowerIdx, endTowerIdx) {
    that.move(startTowerIdx, endTowerIdx);
    if (!that.isWon()) {
      that.run(completionCallback);
    } else {
      completionCallback();
    }
  });
};

var hanoi = new HanoiGame();
hanoi.run(function () {
  console.log("you won!!");
  reader.close();
});
