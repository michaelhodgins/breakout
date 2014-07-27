class BlockMap extends Entity

  ###
  Construct a BlockMap with the given blocks.
  ###
  constructor: (@blocks = []) ->
    super()

  ###
  Update all the blocks in this BlockMap.
  ###
  update: (steps) ->
    super steps
    block.update(steps) for block in @blocks

  ###
  Draw all the blocks in this BlockMap.
  ###
  draw: (context) ->
    super context
    block.draw(context) for block in @blocks

  blocksRemaining: ->
    remaining = 0
    for block in @blocks
      remaining++ if not block.removed

    remaining

  reset: ->
    for block in @blocks
      block.reset()

  ###
  Build the standard grid of blocks.
  ###
  @getBlockMap: (game) ->
    blockMap = new BlockMap []
    leftGutter = 25
    topGutter = 30
    padding = 0
    blockHeight = 20
    numBlocksPerRow = 13
    blockWidth = (game.playArea.width - leftGutter * 2 - padding * (numBlocksPerRow - 1)) / numBlocksPerRow
    numRows = 9
    for rowNum in [0...numRows]
      for blockNum in [0...numBlocksPerRow]
        x = game.playArea.x + leftGutter + (blockWidth * blockNum) + padding * blockNum
        y = game.playArea.y + topGutter + (blockHeight * rowNum) + padding * rowNum
        blockMap.blocks.push(new Block game, x, y, blockWidth, blockHeight, rowNum + blockNum % 5)
    blockMap
