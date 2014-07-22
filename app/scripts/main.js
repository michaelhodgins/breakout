// Generated by CoffeeScript 1.7.1
var canvas, game;

window.requestAnimationFrame = window.requestAnimationFrame || window.mozRequestAnimationFrame || window.webkitRequestAnimationFrame || window.msRequestAnimationFrame;

canvas = $('#breakout')[0];

game = new Game(canvas);

game.colours = ColourScheme.getMooduinoColourScheme();

game.entities = [game.background = new Background(), game.blockMap = BlockMap.getBlockMap(), game.ball = new Ball(), game.paddle = new Paddle()];

game.start();

canvas.focus();
