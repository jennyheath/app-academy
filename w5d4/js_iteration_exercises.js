Array.prototype.bubbleSort = function() {
  var sorted = false;
  while (!sorted) {
    sorted = true;
    for (var i = 0; i < this.length - 1; i++) {
      if (this[i + 1] < this[i]) {
        var temp = this[i];
        this[i] = this[i + 1];
        this[i + 1] = temp;
        sorted = false;
      }
    }
  }
  return this;
}

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
