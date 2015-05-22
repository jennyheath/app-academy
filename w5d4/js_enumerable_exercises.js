Array.prototype.myEach = function(otherFunction) {
  for (var i = 0; i < this.length; i++) {
    otherFunction(this[i]);
  }
}

var testFunction = function(num) {
  console.log(num);
}

var arr = [1, 2, 3];
// arr.myEach(testFunction);

Array.prototype.myMap = function(otherFunction) {
  var arr2 = [];
  var addElement = function(el) {
    arr2.push(otherFunction(el));
  }

  this.myEach(addElement);
  return arr2;
}

var timesTwo = function(num) {
  return num * 2;
}

// console.log(arr.myMap(timesTwo));

Array.prototype.myInject = function(otherFunction) {
  var acc = this[0];
  var newArray = this.slice(1, this.length);
  var accumulate = function(x) {
    acc = otherFunction(acc, x);
  }

  newArray.myEach(accumulate);
  return acc;
}

var sum = function(x, y) {
  return x + y;
}

console.log(arr.myInject(sum));
