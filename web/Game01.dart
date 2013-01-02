import 'dart:html';
import 'package:game_loop/game_loop.dart';

import '../lib/texture_manager.dart';
import '../lib/screen_manager.dart';
import '../lib/home_screen.dart';

GameLoop gameLoop;
ScreenManager screenManager;
CanvasRenderingContext2D renderContext;

void update(GameLoop gameLoop) {
  document.body.style.cursor = 'default';  
  
  screenManager.update(gameLoop);
  
  renderContext.beginPath();
  
  renderContext.clearRect(0, 0, renderContext.canvas.clientWidth,
      renderContext.canvas.clientHeight);
  
  screenManager.draw(renderContext);
  
  renderContext.closePath();
}

void load()
{
   TextureManager.load("new_game.png");
   TextureManager.load("about.png");
   TextureManager.load("node.png");
}

void onLoadComplete()
{
  screenManager = new ScreenManager();
  screenManager.addScreen(new HomeScreen());
}

void main() {
  var canvasElement = query('#gameCanvas');
  renderContext = canvasElement.getContext('2d');  
  
  load();
  onLoadComplete();
  
  gameLoop = new GameLoop(canvasElement);
  gameLoop.onUpdate = update;
  gameLoop.start();
}