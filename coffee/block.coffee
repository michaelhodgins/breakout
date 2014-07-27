class Block extends Entity
  ###
  Construct a block.
  ###
  constructor: (@game, @x = 0, @y = 0, @width = 30, @height = 15, @colourCode = 0, @hitPoints = 1) ->
    super @x, @y
    @removed = false
    @hits = 0

  ###
  Update the block.
  ###
  update: (steps) ->
    super steps

  ###
  Draw the block.
  ###
  draw: (context) ->
    if not @removed
      context.beginPath()
      context.rect @x, @y, @width, @height
      context.fillStyle = @game.colours.getColour "#{@colourCode}Background"
      context.fill()
      context.lineWidth = 1
      context.strokeStyle = @game.colours.getColour "#{@colourCode}stroke"
      context.stroke()

  ###
  Call to indicate that the block has been hit.
  ###
  incrementHitCount: ->
    @hits++
    @removed = true if @hits >= @hitPoints
