Function.prototype.myBind = function(context) {
  var fn = this;
  // console.log(typeof fn);

  var boundFun = function () {
    return fn.apply(context);
  };

  return boundFun;
};

function myFun() {
  var hi = "hi";
}

function dummyFunc () {
  console.log("Hello imma func.");
}

function Cat(name) {
  this.name = name;
  this.meow = function () {
    console.log("I'm in the function");
    return (this.name);
  };
}

setTimeout(function () {
  console.log("I'm in a timeout");
}, 0);

// Cat.prototype.meow

console.log("Start Stuff");
var cat = new Cat('breakfast');

var unboundMethod = cat.meow;

var boundMethod = cat.meow.myBind(cat);

console.log("Run Bound Function");

// console.log(unboundMethod());
console.log(boundMethod());
