function Cat(name, owner) {
  this.name = name,
  this.owner = owner
  // this.cuteStatement = function() {
  //   return owner + " loves " + name;
  // }
}

Cat.prototype.cuteStatement = function() {
  return this.owner + " loves " + this.name;
}

var markov = new Cat("Markov", "Ned");
var curie = new Cat("Curie", "Ned");

// console.log(markov.cuteStatement());

Cat.prototype.cuteStatement = function() {
  return "Everyone loves " + this.name;
}

// console.log(markov.cuteStatement());

Cat.prototype.meow = function() {
  return "meow"
}

markov.meow = function() {
  return "meow meow"
}

console.log(markov.meow());
console.log(curie.meow());
