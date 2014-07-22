class BlockMap extends Entity

  constructor: (@blocks = []) ->
    super()

  update: (steps) ->
    super steps
    block.update(steps) for block in @blocks

  draw: (context) ->
    super context
    block.draw(context) for block in @blocks

  @getBlockMap: ->
    blockMap = new BlockMap []
    leftGutter = 15
    topGutter = 30
    padding = 0
    blockHeight = 20
    numBlocksPerRow = 6
    blockWidth = (game.width - leftGutter * 2 - padding * (numBlocksPerRow - 1)) / numBlocksPerRow
    numRows = 7
    for rowNum in [0...numRows]
      for blockNum in [0...numBlocksPerRow]
        x = leftGutter + (blockWidth * blockNum) + padding * blockNum
        y = topGutter + (blockHeight * rowNum) + padding * rowNum
        blockMap.blocks.push(new Block x, y, blockWidth, blockHeight, rowNum + blockNum % 5)
    blockMap