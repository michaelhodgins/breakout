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

    @desiredStep = 1000 / @fps
    @debug = false #set to true to see debug information about the game on the screen
    @paused = false #if true, the game is paused
    @pausedLoops = 0 #used to keep track of how many loops the game has been paused for
    @runningLoops = 0 #used to track how long the game has been unpaused for.

    @keyPressed = {} #which keys are pressed

    #monitor the keys that are pressed.
    $(@canvas).on 'keydown keyup', (event) =>
      keyName = Game.keys[event.which]

      if keyName
        @keyPressed[keyName] = event.type is 'keydown'
        event.preventDefault()

    #add the game entities.
    @setup()

  ###
  Add an Entity object to the game. If name is given, the entity is associated with that name, thad this can be used
  later to retrieve the entity by calling getNamedEntity().
  ###
  addEntity: (entity, name = false) ->
    @entities.push entity
    @namedEntities[name] = entity if name
    if name is "scoreBoard"
      @playArea.y += entity.height

  ###
  Return the entity associated with the given name.
  ###
  getNamedEntity: (name) ->
    @namedEntities[name]

  ###
  Call to indicate that a life has been lost.
  ###
  lifeLost: ->
    @lives--
    if @lives > 0
      @getNamedEntity("ball").reset()
    else
      @gameOver()

  ###
  Call to indicate that a the given block has been hit. This is used for scoring.
  ###
  blockHit: (block) ->
    if block.hits < block.hitPoints
      @score++
    else
      @score += 5

  ###
  Render the game over message.
  ###
  gameOver: ->
    @getNamedEntity("scoreBoard").draw @context
    @messageBox "Game Over!", "Press S to play again."

  ###
  Set up the game's entities, score, lives and play area.
  ###
  setup: ->
    @lives = 3
    @score = 0

    @entities = []
    @namedEntities = {}

    @playArea = {
      x: 0
      y: 0
      @height
      @width
    }

    @addEntity new Background(@), "background"
    @addEntity new ScoreBoard(@), "scoreBoard"
    @addEntity BlockMap.getBlockMap(@), "blockMap"
    @addEntity new Ball(@), "ball"
    @addEntity new Paddle(@), "paddle"

  ###
  Call to pause the game.
  ###
  pause: ->
    #only pause the game if it's been running for 5 loops (this "debounces" the pause button).
    if @runningLoops > 5
      @runningLoops = 0
      @paused = true
      @messageBox "Paused", "Press P to continue." if @paused

  ###
  Call to unpause the game.
  ###
  unpause: ->
    #only unpause the game if it's been paused for 5 loops (this "debounces" the continue button).
    if @pausedLoops > 5
      @pausedLoops = 0
      @paused = false

  nextLevel: ->
    console.log "nextLevel"
    @getNamedEntity("blockMap").reset()
    @getNamedEntity("ball").reset()

  ###
  Render a message box.
  ###
  messageBox: (title, text) ->
    @context.beginPath()
    @context.rect @width / 5, @height / 3, @width / 5 * 3, @height / 3
    @context.fillStyle = @colours.getColour "messageBoxBackground"
    @context.fill()

    @context.fillStyle = @colours.getColour "messageBoxForeground"
    @context.font = '32px monospace'
    @context.fillText title, @width / 4, @height / 2 - 20
    @context.font = '12px monospace'
    @context.fillText text, @width / 4, @height / 2 + 30

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
    @setup() if @lives < 1 and @keyPressed.S
    if @lives > 0
      if @keyPressed.P
        if not @paused
          @pause()
        else
          @unpause()

      if @paused
        @pausedLoops++
      else
        @runningLoops++

      @nextLevel() if @getNamedEntity("blockMap").blocksRemaining() is 0

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
    if @lives > 0 and not @paused
      for entity in @entities
        entity.update steps if entity.update

    # Output some interesting data if @debug is true
    if @debug
      $("#vector").html "Ball Vector: #{@ball.vector.toFixed 1}°"

  ###
  Draw each entity.
  ###
  draw: ->
    if @lives > 0 and not @paused
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
    32: "space"
    37: "left"
    38: "up"
    39: "right"
    40: "down"
    80: "P"
    83: "S"
