// Generated by CoffeeScript 1.7.1
var BlockMap,
  __hasProp = {}.hasOwnProperty,
  __extends = function(child, parent) { for (var key in parent) { if (__hasProp.call(parent, key)) child[key] = parent[key]; } function ctor() { this.constructor = child; } ctor.prototype = parent.prototype; child.prototype = new ctor(); child.__super__ = parent.prototype; return child; };

BlockMap = (function(_super) {
  __extends(BlockMap, _super);

  function BlockMap(blocks) {
    this.blocks = blocks != null ? blocks : [];
    BlockMap.__super__.constructor.call(this);
  }

  BlockMap.prototype.update = function(steps) {
    var block, _i, _len, _ref, _results;
    BlockMap.__super__.update.call(this, steps);
    _ref = this.blocks;
    _results = [];
    for (_i = 0, _len = _ref.length; _i < _len; _i++) {
      block = _ref[_i];
      _results.push(block.update(steps));
    }
    return _results;
  };

  BlockMap.prototype.draw = function(context) {
    var block, _i, _len, _ref, _results;
    BlockMap.__super__.draw.call(this, context);
    _ref = this.blocks;
    _results = [];
    for (_i = 0, _len = _ref.length; _i < _len; _i++) {
      block = _ref[_i];
      _results.push(block.draw(context));
    }
    return _results;
  };

  BlockMap.getBlockMap = function(game) {
    var blockHeight, blockMap, blockNum, blockWidth, leftGutter, numBlocksPerRow, numRows, padding, rowNum, topGutter, x, y, _i, _j;
    blockMap = new BlockMap([]);
    leftGutter = 25;
    topGutter = 30;
    padding = 0;
    blockHeight = 20;
    numBlocksPerRow = 13;
    blockWidth = (game.width - leftGutter * 2 - padding * (numBlocksPerRow - 1)) / numBlocksPerRow;
    numRows = 7;
    for (rowNum = _i = 0; 0 <= numRows ? _i < numRows : _i > numRows; rowNum = 0 <= numRows ? ++_i : --_i) {
      for (blockNum = _j = 0; 0 <= numBlocksPerRow ? _j < numBlocksPerRow : _j > numBlocksPerRow; blockNum = 0 <= numBlocksPerRow ? ++_j : --_j) {
        x = leftGutter + (blockWidth * blockNum) + padding * blockNum;
        y = topGutter + (blockHeight * rowNum) + padding * rowNum;
        blockMap.blocks.push(new Block(game, x, y, blockWidth, blockHeight, rowNum + blockNum % 5));
      }
    }
    return blockMap;
  };

  return BlockMap;

})(Entity);
