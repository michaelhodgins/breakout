// Generated by CoffeeScript 1.7.1
var Paddle,
  __hasProp = {}.hasOwnProperty,
  __extends = function(child, parent) { for (var key in parent) { if (__hasProp.call(parent, key)) child[key] = parent[key]; } function ctor() { this.constructor = child; } ctor.prototype = parent.prototype; child.prototype = new ctor(); child.__super__ = parent.prototype; return child; };

Paddle = (function(_super) {
  __extends(Paddle, _super);


  /*
  Construct a Paddle.
   */

  function Paddle(game) {
    this.game = game;
    Paddle.__super__.constructor.call(this);
    this.height = 8;
    this.width = 60;
    this.reset();
  }


  /*
  Reset the Paddle's position.
   */

  Paddle.prototype.reset = function() {
    this.x = (this.game.playArea.width - this.width) / 2;
    this.y = this.game.playArea.height - this.height * 2;
    return this.maximumVelocity = 8;
  };


  /*
  Update the Paddle.
   */

  Paddle.prototype.update = function(steps) {
    if (this.game.keyPressed.left && this.game.keyPressed.right || !this.game.keyPressed.left && !this.game.keyPressed.right) {
      this.velocity = 0;
    } else if (this.game.keyPressed.left) {
      this.velocity = this.maximumVelocity;
      this.vector = 180;
    } else if (this.game.keyPressed.right) {
      this.velocity = this.maximumVelocity;
      this.vector = 360;
    }
    Paddle.__super__.update.call(this, steps);
    return this.x = Math.min(Math.max(this.x, this.game.playArea.x), this.game.playArea.width - this.width);
  };


  /*
  Draw the paddle.
   */

  Paddle.prototype.draw = function(context) {
    context.beginPath();
    context.rect(this.x, this.y, this.width, this.height);
    context.fillStyle = this.game.colours.getColour('paddleBackground');
    context.fill();
    context.lineWidth = 1;
    context.strokeStyle = this.game.colours.getColour('paddleStroke');
    return context.stroke();
  };


  /*
  Returns the angle that is perpendicular to the top of the paddle at the given x coordinate.
   */

  Paddle.prototype.getNormalAngleAt = function(x) {
    var segments;
    segments = 3;
    if (x > this.width / segments && x < this.width / segments * (segments - 1)) {
      return 270;
    } else {
      return 270 - (this.width / 4) + (x / 2);
    }
  };

  return Paddle;

})(Entity);
