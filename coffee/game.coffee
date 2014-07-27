###
Game is a class for coordinating the drawing surface, game entities and game loop.
###
class Game
  ###
  Construct the game with the given drawing surface. If fps is given, it is only used if the
  browser doesn't support a native FPS system.
  ###
  constructor: (@canvas, @fps = 60, @colours = null) ->
    @context = @canvas.getContext '2d'
    @width = @canvas.width
    @height = @canvas.height

    @playArea = {
      x: 0
      y: 0
      @height
      @width
    }

    @lives = 3
    @score = 0

    @entities = []
    @namedEntities = {}
    @desiredStep = 1000 / @fps
    @debug = false #set to true to see debug information about the game on the screen

    @keyPressed = {}

    #monitor the keys that are pressed.
    $(@canvas).on 'keydown keyup', (event) =>
      keyName = Game.keys[event.which]

      if keyName
        @keyPressed[keyName] = event.type is 'keydown'
        event.preventDefault()

  addEntity: (entity, name = false) ->
    @entities.push entity
    @namedEntities[name] = entity if name
    if name is "scoreBoard"
      @playArea.y += entity.height

  getNamedEntity: (name) ->
    @namedEntities[name]

  lifeLost: (callback) ->
    @lives--
    if @lives > 0
      @getNamedEntity("ball").reset()
    else
      @gameOver()

  blockHit: (block) ->
    if block.hits < block.hitPoints
      @score++
    else
      @score += 5

  gameOver: ->



  ###
  Called to start the game loop
  ###
  start: ->
    @recordUpdate()
    @frame =>
      @loop()

  ###
  Sets up the mechanism for repeatedly updating and drawing the game.
  ###
  frame: (callFrame) ->
    # does the browser have a native FPS system?
    if window.requestAnimationFrame
      window.requestAnimationFrame =>
        callFrame()
        @frame callFrame
    # no, so fall back on using setInterval()
    else
      interval = 1000 / @fps
      setInterval ->
        callFrame()
      , interval

  ###
  Execute one update and drawing loop.
  ###
  loop: ->
    #calculate how much time has passed since the last update
    startTime = new Date().getTime()
    timePassed = startTime - @lastUpdate
    steps = @desiredStep / timePassed
    @update steps
    @draw()
    @recordUpdate()

  ###
  Update all the entities once.
  ###
  update: (steps) ->
    if @lives > 0
      for entity in @entities
        entity.update steps if entity.update

    # Output some interesting data if @debug is true
    if @debug
      $("#vector").html "Ball Vector: #{@ball.vector.toFixed 1}°"

  ###
  Draw each entity.
  ###
  draw: ->
    @context.clearRect 0, 0, @canvas.width, @canvas.height
    for entity in @entities
      entity.draw @context if entity.draw

  ###
  Call to record when an update cycle was completed
  ###
  recordUpdate: ->
    @lastUpdate = new Date().getTime()

  ###
  Constants for some keys we're interesting in
  ###
  @keys:
    32: 'space'
    37: 'left'
    38: 'up'
    39: 'right'
    40: 'down'
