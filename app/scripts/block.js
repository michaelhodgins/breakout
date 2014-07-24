// Generated by CoffeeScript 1.7.1
var Block,
  __hasProp = {}.hasOwnProperty,
  __extends = function(child, parent) { for (var key in parent) { if (__hasProp.call(parent, key)) child[key] = parent[key]; } function ctor() { this.constructor = child; } ctor.prototype = parent.prototype; child.prototype = new ctor(); child.__super__ = parent.prototype; return child; };

Block = (function(_super) {
  __extends(Block, _super);

  function Block(game, x, y, width, height, colourCode, hitPoints) {
    this.game = game;
    this.x = x != null ? x : 0;
    this.y = y != null ? y : 0;
    this.width = width != null ? width : 30;
    this.height = height != null ? height : 15;
    this.colourCode = colourCode != null ? colourCode : 0;
    this.hitPoints = hitPoints != null ? hitPoints : 1;
    Block.__super__.constructor.call(this, this.x, this.y);
    this.removed = false;
    this.hits = 0;
  }

  Block.prototype.update = function(steps) {
    return Block.__super__.update.call(this, steps);
  };

  Block.prototype.draw = function(context) {
    if (!this.removed) {
      context.beginPath();
      context.rect(this.x, this.y, this.width, this.height);
      context.fillStyle = this.game.colours.getColour("" + this.colourCode + "Background");
      context.fill();
      context.lineWidth = 1;
      context.strokeStyle = this.game.colours.getColour("" + this.colourCode + "stroke");
      return context.stroke();
    }
  };

  Block.prototype.incrementHitCount = function() {
    this.hits++;
    if (this.hits >= this.hitPoints) {
      return this.removed = true;
    }
  };

  return Block;

})(Entity);
