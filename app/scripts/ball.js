// Generated by CoffeeScript 1.7.1

/*
The Ball class is an Entity.
 */
var Ball,
  __hasProp = {}.hasOwnProperty,
  __extends = function(child, parent) { for (var key in parent) { if (__hasProp.call(parent, key)) child[key] = parent[key]; } function ctor() { this.constructor = child; } ctor.prototype = parent.prototype; child.prototype = new ctor(); child.__super__ = parent.prototype; return child; };

Ball = (function(_super) {
  __extends(Ball, _super);


  /*
  Construct a ball
   */

  function Ball(game, radius) {
    this.game = game;
    this.radius = radius != null ? radius : 4;
    Ball.__super__.constructor.call(this);
    this.height = this.radius * 2;
    this.reset();
  }


  /*
  Put the ball back into it's starting position and give it a random vector.
   */

  Ball.prototype.reset = function() {
    var maxVector, minVector, randVector;
    this.x = this.game.playArea.width / 2;
    this.y = this.game.playArea.height / 2;
    this.velocity = 4.5;
    this.vector = 90;
    minVector = -25;
    maxVector = 25;
    randVector = Math.floor(Math.random() * (maxVector - minVector + 1) + minVector);
    return this.vector += randVector;
  };


  /*
  Update the position of the ball, taking into account the entities around
  the ball.
   */

  Ball.prototype.update = function(steps) {
    var block, paddle, _i, _len, _ref, _results;
    Ball.__super__.update.call(this, steps);
    if (this.y - this.radius >= this.game.playArea.height) {
      this.game.lifeLost();
    } else if (this.y <= this.radius + this.game.playArea.y) {
      this.y = this.radius + this.game.playArea.y;
      this.bounce(90);
    } else if (this.x <= this.radius + this.game.playArea.x) {
      this.x = this.radius;
      this.bounce(360);
    } else if (this.x >= this.game.playArea.width - this.radius) {
      this.x = this.game.width - this.radius;
      this.bounce(180);
    }
    paddle = this.game.getNamedEntity("paddle");
    if (this.intersect(paddle)) {
      this.y = paddle.y - this.radius;
      return this.bounce(paddle.getNormalAngleAt(this.x - paddle.x));
    } else {
      _ref = this.game.getNamedEntity("blockMap").blocks;
      _results = [];
      for (_i = 0, _len = _ref.length; _i < _len; _i++) {
        block = _ref[_i];
        if (!block.removed && this.intersect(block)) {
          block.incrementHitCount();
          this.game.blockHit(block);
          if (this.x >= block.x + block.width - this.velocity) {
            _results.push(this.bounce(360));
          } else if (this.y <= block.y + this.velocity) {
            _results.push(this.bounce(270));
          } else if (this.y >= block.y + block.height - this.velocity) {
            _results.push(this.bounce(90));
          } else if (this.x <= block.x + this.velocity) {
            _results.push(this.bounce(180));
          } else {
            _results.push(void 0);
          }
        } else {
          _results.push(void 0);
        }
      }
      return _results;
    }
  };


  /*
  Draw the ball on the given drawing surface.
   */

  Ball.prototype.draw = function(context) {
    context.beginPath();
    context.arc(this.x, this.y, this.radius, 0, 2 * Math.PI, false);
    context.fillStyle = this.game.colours.getColour("ballBackground");
    context.fill();
    context.lineWidth = 1;
    context.strokeStyle = this.game.colours.getColour("ballStroke");
    return context.stroke();
  };


  /*
  Bounce the ball on the given surface. The surface is specified by it's perpendicular angle.
   */

  Ball.prototype.bounce = function(normal) {
    var m, o;
    o = this.vector - 180 - normal;
    m = normal - o;
    if (m <= 0) {
      m += 360;
    } else if (m > 360) {
      m -= 360;
    }
    return this.vector = m;
  };


  /*
  Does this ball intersect with the given other entity?
   */

  Ball.prototype.intersect = function(other) {
    var closestX, closestY, distance;
    closestX = Entity.constrain(this.x, other.x, other.x + other.width);
    closestY = Entity.constrain(this.y, other.y, other.y + other.height);
    distance = Entity.calcDistance(this.x, this.y, closestX, closestY);
    if (distance < this.radius) {
      return true;
    } else {
      return false;
    }
  };

  return Ball;

})(Entity);
