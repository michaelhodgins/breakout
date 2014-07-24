###
The background class renders the part of the game behind the paddle, ball, and blocks.
###
class Background extends Entity
  constructor: (@game) ->
    super()

  draw: (context) ->
    context.fillStyle = @game.colours.getColour 'gameBackground'
    context.fillRect @game.playArea.x, @game.playArea.y, @game.playArea.width, @game.playArea.height
