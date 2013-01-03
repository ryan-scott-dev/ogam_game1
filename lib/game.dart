library game;

import 'dart:html';
import 'package:game_loop/game_loop.dart';
import 'package:js/js.dart' as js;

import '../lib/texture_manager.dart';
import '../lib/screen_manager.dart';

import '../lib/size.dart';
import '../lib/loading_screen.dart';

class Game {
  GameLoop gameLoop;
  ScreenManager screenManager;
  CanvasRenderingContext2D renderContext;
  List<String> resources;
  int loadedResources = 0;
  LoadingScreen loadingScreen;
  
  void update(GameLoop gameLoop) {
    screenManager.update(gameLoop);
    
    screenManager.draw();
  }

  void load()
  {
    for(var file in resources)
    {
      TextureManager.load(file, callback: fileLoaded);  
    }
  }
  
  void fileLoaded(String file)
  {
    loadedResources++;
    loadingScreen.updateProgress(loadedResources, resources.length);
  }
  
  void start() {
    screenManager = new ScreenManager('canvas-container', new Size(width: 640, height: 480));
    loadingScreen = new LoadingScreen(screenManager);
    screenManager.addScreen(loadingScreen);
    
    load();
    
    gameLoop = new GameLoop(screenManager.canvasElement);
    gameLoop.onUpdate = update;
    gameLoop.start();
  }
}
