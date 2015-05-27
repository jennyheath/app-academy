var range = function(start, end) {
  if (end <= start) {
    return [];
  } else {
    return [start].concat(range(start + 1, end));
  }
}

var exp = function(base, pow) {
  if (pow === 0) {
    return 1;
  } else if (pow === 1) {
    return base;
  } else if (pow % 2 === 0) {
    return exp(base, pow /2)*exp(base, pow /2);
  } else {
    return base * exp(base, (pow - 1) / 2) * exp(base, (pow - 1) / 2);
  }
}

var fib = function(n) {
  if (n === 0) {
    return [];
  } else if (n === 1) {
    return [1];
  } else if (n === 2) {
    return [1, 1];
  } else {
    var fibs = fib(n - 1)
    fibs.push(fibs[fibs.length - 1] + fibs[fibs.length - 2]);
    return fibs;
  }
}

var bsearch = function(array, target) {
  var middle = Math.floor(array.length / 2);
  if (array[middle] > target) {
    return bsearch(array.slice(0, middle), target);
  } else if (array[middle] < target) {
    var rest = bsearch(array.slice(middle + 1, array.length), target);
    if (rest !== undefined) {
      return middle + 1 + rest;
    } else {
      return undefined;
    }
  } else if (array[middle] === target) {
    return middle;
  } else {
    return undefined;
  }
}

var makeChange = function(amt, coins) {
  // coins.bubbleSort();
  if (coins.length === 0 || amt <= 0) {
    return [];
  } else if (coins.length === 1 && coins[0] === amt) {
    return coins;
  } else if (coins[0] <= amt) {
    // console.log("coins");
    // console.log(coins);
    // console.log("amt");
    // console.log(amt);
    var option1 = [coins[0]].concat(makeChange(amt - coins[0], coins));
    var option2 = [coins[1]].concat(makeChange(amt - coins[1], coins.slice(1, coins.length)));

    if (option1.length < option2.length) {
      return option1;
    } else {
      return option2;
    }
  } else {
    return makeChange(amt, coins.slice(1, coins.length));
  }
}

// console.log(makeChange(14, [10, 7, 1]));

var merge = function(array1, array2) {
  var i = array1[0];
  var j = array2[0];
  if (array1.length === 0 || array2.length === 0) {
    return array1.concat(array2)
  } else if (i < j) {
    return [i].concat(merge(array1.slice(1, array1.length), array2))
  } else {
    return [j].concat(merge(array1, array2.slice(1, array2.length)))
  }
}
//
// var arr1 = [1,3,4];
// var arr2 = [2,4, 7];
// console.log(merge(arr1, arr2));

var mergeSort = function(array) {
  if (array.length <= 1) {
    return array;
  } else {
    var middle = Math.floor(array.length / 2);
    return merge(mergeSort(array.slice(0, middle)), mergeSort(array.slice(middle, array.length)));
  }
}

// var arr = [1, 6, 2, 8, 3, 4, 9, 4]
// console.log(mergeSort(arr));

var subsets = function(array) {
  if (array.length === 0) {
    return array;
  } else if (array.length === 1){
    return [[], array]
  } else {
    var withoutElement = subsets(array.slice(1,array.length));
    var withElement = []
    for (var i = 0; i < withoutElement.length; i++) {
      withElement.push(withoutElement[i].concat(array[0]))
    }
    return withoutElement.concat(withElement);
  }
}

// console.log(subsets([3, 2, 1]));
