class ColourScheme
  ###
  Construct a ColourScheme with the given colours.
  ###
  constructor: (@colours) ->

  ###
  Get the named colour.
  ###
  getColour: (identifier) ->
    @colours[identifier]

  ###
  Get the standard colour scheme.
  ###
  @getMooduinoColourScheme: ->
    new ColourScheme
      gameBackground: "#DFF"
      ballBackground: "#0F0"
      ballStroke: "#030"
      paddleBackground: "yellow"
      paddleStroke: "black"
      scoreBoardBackground: "#333"
      scoreBoardForeground: "#CCC"
      messageBoxBackground: "Black"
      messageBoxForeground: "White"
