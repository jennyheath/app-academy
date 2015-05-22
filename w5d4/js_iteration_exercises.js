Array.prototype.bubbleSort = function() {
  var sorted = false;
  while (!sorted) {
    var swaps = 0;
    for (var i = 0; i < this.length - 1; i++) {
      if (this[i + 1] < this[i]) {
        var temp = this[i];
        this[i] = this[i + 1];
        this[i + 1] = temp;
        swaps++;
      }
    }
    if (swaps === 0) {
      sorted = true;
    }
  }
  return this;
}

var array = [5, 4, 2, 3, 10];
// console.log(array.bubbleSort());

////////////////

String.prototype.substring = function() {
  var result = [];
  for (var i = 0; i < this.length; i++) {
    for (var j = i + 1; j < this.length + 1; j++) {
      result.push(this.slice(i,j))
    }
  }
  return result;
}

var word = "catx";
console.log(word.substring());
