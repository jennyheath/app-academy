var readline = require('readline');

var reader = readline.createInterface({
  input: process.stdin,
  output: process.stdout
});

var askIfGreaterThan = function(el1, el2, callback) {
  reader.question(("Is " + el1 + " greater than " + el2 + "?:  "),
  function (answer) {
    if (answer === "yes") {
      callback(true);
    } else if (answer === "no") {
      callback(false);
    } else {
      console.log("that was a yes or no question");
      askIfGreaterThan(el1, el2, callback);
    }
  });
};


var innerBubbleSortLoop = function(arr, i, madeAnySwaps, outerBubbleSortLoop) {
  if (i < arr.length - 1) {
    askIfGreaterThan(arr[i], arr[i+1], function (isGreaterThan) {
      if (isGreaterThan) {
        var temp = arr[i];
        arr[i] = arr[i+1];
        arr[i+1] = temp;
      }
    innerBubbleSortLoop(arr, i + 1, isGreaterThan, outerBubbleSortLoop);
    });
  } else if (i === arr.length - 1) {
    outerBubbleSortLoop(madeAnySwaps);
  }
};

var absurdBubbleSort = function(arr, sortCompletionCallback) {
  var outerBubbleSortLoop = function(madeAnySwaps) {
    if (madeAnySwaps) {
      innerBubbleSortLoop(arr, 0, false, outerBubbleSortLoop);
    } else {
      sortCompletionCallback(arr);
    }
  };
  outerBubbleSortLoop(true);
};

absurdBubbleSort([1, 5, 2, 3, 4], function (arr) {
  console.log("Sorted?:" + arr);
  reader.close();
});
