###
The Ball class is an Entity.
###
class Ball extends Entity

  ###
  Construct a ball
  ###
  constructor: (@radius = 4) ->
    super()
    @height = @radius * 2
    @reset()

  reset: ->
    @x = game.width / 2
    @y = game.height / 2
    @velocity = 4
    @vector = 90
    #start the ball moving within a 50 degree arc, randomly
    minVector = -25
    maxVector = 25
    randVector = Math.floor Math.random() * (maxVector - minVector + 1) + minVector
    @vector += randVector

  ###
  Update the position of the ball, taking into account the entities around
  the ball.
  ###
  update: (steps) ->
    super steps
    #if the ball has reached the bottom of the game area, reset, otherwise, if the ball has reach the top, left, or
    #right of the game area, bounce it.
    if @y - @radius >= game.height
      @reset()
    else if @y <= @radius
      @y = @radius
      @bounce 90 #90 is perpendicular to the top
    else if @x <= @radius
      @x = @radius
      @bounce 360 # 360 is perpendicular to the left wall
    else if @x >= game.width - @radius
      @x = game.width - @radius
      @bounce 180 #180 is perpendicular to the right wall

    if @intersect game.paddle
      @y = game.paddle.y - @radius
      @bounce game.paddle.getNormalAngleAt(@x - game.paddle.x)

  ###
  Draw the ball on the given drawing surface.
  ###
  draw: (context) ->
    context.beginPath()
    context.arc @x, @y, @radius, 0, 2 * Math.PI, false
    context.fillStyle = game.colours.getColour "ballBackground"
    context.fill()
    context.lineWidth = 1
    context.strokeStyle = game.colours.getColour "ballStroke"
    context.stroke()

  ###
  Bounce the ball on the given surface. The surface is specified by it's perpendicular angle.
  ###
  bounce: (normal) ->
    #calculate the angle between the current vector and the normal angle
    o = @vector - 180 - normal
    #calculate the angle between the normal angle and the bounced angle
    m = normal - o
    #make sure that the calculated angle is between 1 and 360
    if m <= 0
      m += 360
    else if m > 360
      m -= 360

    #assign the new vector
    @vector = m

  ###
  Does this ball intersect with the given other entity?
  ###
  intersect: (other) ->
    #find the rectangle's x coordinate closest to the centre of the ball
    closestX = Entity.constrain @x, other.x, other.x + other.width

    #find the rectangle's y coordinate closest to the centre of the ball
    closestY = Entity.constrain @y, other.y, other.y + other.height

    #determine the distance from that point to the centre of the ball
    distance = Entity.calcDistance @x, @y, closestX, closestY

    if distance < @radius
      # a collision has occurred
      true
    else
      # a collision has not occurred
      false
