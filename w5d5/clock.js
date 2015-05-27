function Clock () {
  this.currentTime = null;
}

Clock.TICK = 5000;

Clock.prototype.printTime = function () {
  console.log([this.currentTime.getHours(), 
               this.currentTime.getMinutes(),
               this.currentTime.getSeconds()
             ].join(":"));
};

Clock.prototype.run = function () {
  this.currentTime = new Date();
  this.printTime();
  var that = this;
  setInterval(this._tick.bind(that), Clock.TICK);
};

Clock.prototype._tick = function () {
  var seconds = this.currentTime.getSeconds();
  this.currentTime.setSeconds(seconds + (Clock.TICK/1000));
  this.printTime();
};

var clock = new Clock();
clock.run();
