#Some browsers have the requestAnimationFrame function, but give it an experiment prefix.
window.requestAnimationFrame = window.requestAnimationFrame or window.mozRequestAnimationFrame or window.webkitRequestAnimationFrame or window.msRequestAnimationFrame

#get the game canvas
canvas = $('#breakout')[0]

#make the game
game = new Game canvas
game.colours = ColourScheme.getMooduinoColourScheme()

#add the game entities.
game.entities = [
  game.background = new Background()
  game.blockMap = BlockMap.getBlockMap()
  game.ball = new Ball()
  game.paddle = new Paddle()
]


#start the game
game.start()

#make sure that the game has focus so that the player doesn't have to click on it.
canvas.focus()
