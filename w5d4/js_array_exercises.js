Array.prototype.myUniq = function(arr) {
  var arr2 = [];
  for (var i = 0; i < arr.length; i++) {
    if (arr2.indexOf(arr[i]) === -1) {
      arr2.push(arr[i]);
    }
  }
  return arr2;
}

Array.prototype.twoSum = function(arr) {
  var arr2 = [];
  for (var i = 0; i < arr.length - 1; i++) {
    for (var j = i + 1; j < arr.length; j++) {
      if (arr[i] + arr[j] === 0) {
        arr2.push([i, j]);
      }
    }
  }
  return arr2;
}

Array.prototype.myTranspose = function(arr) {
  var arr2 = [];
  while (arr2.push([]) < arr[0].length);

  for (var i = 0; i < arr.length; i++) {
    for (var j = 0; j < arr[i].length; j++) {
      arr2[j][i] = arr[i][j];
    }
  }
  return arr2;
}

Array.prototype.stockPicker = function(prices) {
  var maxProfit = 0;
  var bestDays = [];
  for (var i = 0; i < prices.length - 1; i++) {
    for (var j = i + 1; j < prices.length; j++) {
      var currentProfit = prices[j] - prices[i];
      if (currentProfit > maxProfit) {
        maxProfit = currentProfit;
        bestDays = [i, j]
      }
    }
  }
  return bestDays;
}
