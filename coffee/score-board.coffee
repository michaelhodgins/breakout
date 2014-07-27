class ScoreBoard extends Entity
  constructor: (@game, @height = 25) ->
    super()

  update: (steps) ->
    super steps


  draw: (context) ->
#    super context
    context.fillStyle = @game.colours.getColour 'scoreBoardBackground'
    context.fillRect 0, 0, game.width, @height

    context.fillStyle = @game.colours.getColour 'scoreBoardForeground'
    context.font = '12px monospace'
    context.fillText "Score: #{@game.score}", 20, 16

    context.fillText "Lives: #{@game.lives}", @game.width / 2 + 20, 16
