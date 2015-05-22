// Towers of Hanoi
//3 is the smallest

var towers = [[1, 2, 3], [], []];

var over = function() {
  if (towers[0] === [] && (towers[1] === [] || towers[2] === [])) {
    return true;
  } else {
    return false;
  }
}

while (!over()) {
  // var from_tower = prompt("what tower do you want to move a disc from?");
  // var to_tower = prompt("what tower do you want to move a disc to?");

  var from_tower = console.log("what tower do you want to move a disc from?");
  var to_tower = console.log("what tower do you want to move a disc to?");

  var from_disc = towers[from_tower][-1];
  var to_disc = towers[to_tower][-1];

  if (!from_disc) {
    console.log("Cannot move from an empty tower");
    continue;
  }
  if (from_disc > to_disc) {
    console.log("Cannot move big piece onto small piece");
    continue;
  }

  to_tower.push(from_disc);
  from_tower.pop();
  console.log(towers);
}
console.log("You won!!!!");
