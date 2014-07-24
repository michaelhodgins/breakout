// Generated by CoffeeScript 1.7.1

/*
A base class for objects that move around the game area. The can be updated and drawn.
 */
var Entity;

Entity = (function() {

  /*
  Sets up the entities basic properties.
   */
  function Entity(x, y, velocity, vector) {
    this.x = x != null ? x : 0;
    this.y = y != null ? y : 0;
    this.velocity = velocity != null ? velocity : 0;
    this.vector = vector != null ? vector : 0;
  }


  /*
  Update the entity by the given number of steps.
   */

  Entity.prototype.update = function(steps) {
    this.x += this.velocity * (Math.cos(this.degreesToRadians(this.vector))) * steps;
    return this.y += this.velocity * (Math.sin(this.degreesToRadians(this.vector))) * steps;
  };


  /*
  Draw the entity on the given drawing surface.
   */

  Entity.prototype.draw = function(context) {
    context.fillStyle = '#fff';
    return context.fillRect(this.x, this.y, this.width, this.height);
  };


  /*
  Does this entity intersect with the given other entity?
   */

  Entity.prototype.intersect = function(other) {
    return this.y + this.height > other.y && this.y < other.y + other.height && this.x + this.width > other.x && this.x < other.x + other.width;
  };


  /*
  A helper method to transform degrees to radians
   */

  Entity.prototype.degreesToRadians = function(degrees) {
    return degrees * Math.PI / 180;
  };


  /*
  A helper method to transform radians to degrees.
   */

  Entity.prototype.radiansToDegrees = function(radians) {
    return radians * 180 / Math.PI;
  };


  /*
  Returns value if it is within the min - max range, min if value is lower then min, and max if value is
  greater than max.
   */

  Entity.constrain = function(value, min, max) {
    if (value < min) {
      return min;
    } else if (value > max) {
      return max;
    } else {
      return value;
    }
  };


  /*
  Calculates the distance between two points.
   */

  Entity.calcDistance = function(fromX, fromY, toX, toY) {
    var xDistance, yDistance;
    xDistance = Math.abs(fromX - toX);
    yDistance = Math.abs(fromY - toY);
    return Math.sqrt((xDistance * xDistance) + (yDistance * yDistance));
  };

  return Entity;

})();
