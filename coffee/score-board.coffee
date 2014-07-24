class ScoreBoard extends Entity
  constructor: (@game, @height = 25) ->
    super()

  update: (steps) ->
    super steps

  draw: (context) ->
    super context