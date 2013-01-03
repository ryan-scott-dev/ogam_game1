library game;

import 'dart:html';
import 'package:game_loop/game_loop.dart';
import 'package:js/js.dart' as js;

import '../lib/texture_manager.dart';
import '../lib/screen_manager.dart';

import '../lib/size.dart';

class Game {
  GameLoop gameLoop;
  ScreenManager screenManager;
  CanvasRenderingContext2D renderContext;
  List<String> resources;
  
  void update(GameLoop gameLoop) {
    screenManager.update(gameLoop);
    
    screenManager.draw();
  }

  void load()
  {
    for(var file in resources)
    {
      TextureManager.load(file);  
    }
  }

  void onLoadComplete()
  {
  }

  void start() {
    screenManager = new ScreenManager('canvas-container', new Size(width: 640, height: 480));
    
    load();
    onLoadComplete();
    
    gameLoop = new GameLoop(screenManager.canvasElement);
    gameLoop.onUpdate = update;
    gameLoop.start();
  }
}
