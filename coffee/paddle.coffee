class Paddle extends Entity
  constructor: ->
    super()
    @height = 8
    @width = 60
    @reset()

  reset: ->
    @x = (game.width - @width) / 2
    @y = game.height - @height * 2
    @maximumVelocity = 10

  update: (steps) ->
    if game.keyPressed.left and game.keyPressed.right or not game.keyPressed.left and not game.keyPressed.right
      @velocity = 0
    else if game.keyPressed.left
      @velocity = @maximumVelocity
      @vector = 180
    else if game.keyPressed.right
      @velocity = @maximumVelocity
      @vector = 360

    super steps
    @x = Math.min(Math.max(@x, 0), game.width - @width)

  ###
  Draw the paddle.
  ###
  draw: (context) ->
    context.beginPath()
    context.rect @x, @y, @width, @height
    context.fillStyle = game.colours.getColour 'paddleBackground'
    context.fill()
    context.lineWidth = 1
    context.strokeStyle = game.colours.getColour 'paddleStroke'
    context.stroke()

  ###
  Returns the angle that is perpendicular to the top of the paddle at the given x coordinate.
  ###
  getNormalAngleAt: (x) ->
    segments = 4
    if x > @width / segments and x < @width / segments * (segments - 1)
      270
    else
      270 - (@width / 4) + (x / 2)
