Array.prototype.myEach = function(otherFunction) {
  for (var i = 0; i < this.length; i++) {
    otherFunction(this[i]);
  }

  return this;
}

var testFunction = function(num) {
  console.log(num);
}

Array.prototype.myMap = function(otherFunction) {
  var mappedArr = [];
  this.myEach(function(el) {
    mappedArr.push(otherFunction(el));
  });

  return mappedArr;
}

var timesTwo = function(num) {
  return num * 2;
}

Array.prototype.myInject = function(otherFunction) {
  var accumulated = this[0];
  var newArray = this.slice(1);
  newArray.myEach(function(x) {
    accumulated = otherFunction(accumulated, x);
  });

  return accumulated;
}

var sum = function(x, y) {
  return x + y;
}
