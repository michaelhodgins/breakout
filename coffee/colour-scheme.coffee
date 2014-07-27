class ColourScheme
  constructor: (@colours) ->

  setColour: (identifier, colour) ->
    @colours[identifier] = colour

  getColour: (identifier) ->
    @colours[identifier]

  @getMooduinoColourScheme: ->
    new ColourScheme
      gameBackground: "#DFF"
      ballBackground: "#0F0"
      ballStroke: "#030"
      paddleBackground: "yellow"
      paddleStroke: "black"
      scoreBoardBackground: "#333"
      scoreBoardForeground: "#CCC"
