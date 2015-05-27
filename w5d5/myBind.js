Function.prototype.myBind = function(context) {
  var fn = this;
  return function () {
    return fn.apply(context);
  };
};

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

var cat = new Cat('breakfast');

var unboundMethod = cat.meow;

var boundMethod = cat.meow.myBind(cat);

console.log("Run Bound Function");

// console.log(unboundMethod());
console.log(boundMethod());
