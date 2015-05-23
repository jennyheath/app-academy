function Clock () {
  // this.currentTime = new Date();
}

Clock.TICK = 5000;

Clock.prototype.printTime = function () {
  // Format the time in HH:MM:SS
  var hours = this.currentTime.getHours();
  formatted_hours = parseInt(hours) < 10 ? ("0" + hours ): hours
  var minutes = this.currentTime.getMinutes();
  formatted_minutes = parseInt(minutes) < 10 ? "0" + minutes : minutes
  var seconds = this.currentTime.getSeconds();
  formatted_seconds = parseInt(seconds) < 10 ? "0" + seconds : seconds
  console.log(formatted_hours + ":" + formatted_minutes + ":" + formatted_seconds);
};

Clock.prototype.run = function () {
  // 1. Set the currentTime.
  this.currentTime = new Date();
  // 2. Call printTime.
  this.printTime();
  // 3. Schedule the tick interval.
  var that = this;
  setInterval(this._tick.bind(that), Clock.TICK);
};

Clock.prototype._tick = function () {
  // 1. Increment the currentTime.
  var seconds = this.currentTime.getSeconds();
  this.currentTime.setSeconds(seconds + (Clock.TICK/1000));
  // 2. Call printTime.
  this.printTime();
};

var clock = new Clock();
clock.run();
