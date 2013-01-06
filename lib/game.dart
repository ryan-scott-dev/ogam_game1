library game;

import 'dart:html';
import 'package:game_loop/game_loop.dart';
import 'package:js/js.dart' as js;

import '../lib/texture.dart';
import '../lib/texture_manager.dart';
import '../lib/screen_manager.dart';
import '../lib/audio_manager.dart';

import '../lib/size.dart';
import '../lib/loading_screen.dart';

class Game {
  GameLoop gameLoop;
  ScreenManager screenManager;
  CanvasRenderingContext2D renderContext;
  Map<String, List<String>> resources;
  int loadedResources = 0, totalResources = 0;
  Function onLoadComplete;
  
  LoadingScreen loadingScreen;
  
  void update(GameLoop gameLoop) {
    screenManager.update(gameLoop);
    
    screenManager.draw();
  }

  void load()
  {
    AudioManager.setup();
    
    totalResources = resources.values.reduce(0, (total, resources) => total += resources.length);
    
    for(var file in resources['textures'])
    {
      TextureManager.load(file, callback: fileLoaded);  
    }
    for(var file in resources['audio'])
    {
      AudioManager.load(file, callback: fileLoaded);  
    }
  }
  
  void fileLoaded(var resourceLoaded)
  {
    loadedResources++;
    loadingScreen.updateProgress(loadedResources, totalResources);
    
    if(loadedResources == totalResources && onLoadComplete != null)
    {
      onLoadComplete();
    }
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
