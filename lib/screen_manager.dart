library screen_manager;

import 'dart:html';
import 'package:game_loop/game_loop.dart';
import 'package:js/js.dart' as js;

import 'game_screen.dart';
import 'size.dart';

class ScreenManager {
  List<GameScreen> _screens = new List<GameScreen>(); 
  List<GameScreen> get screens => _screens;
  
  num get screenWidth => canvasElement.clientWidth;
  num get screenHeight => canvasElement.clientHeight;
  
  var canvasElement;
  js.Proxy _stage;
  
  ScreenManager(String canvasId, Size canvasSize)
  {
    canvasElement = document.query("#$canvasId");
    
    js.scoped(() {
      var kinetic = js.context.Kinetic;
      _stage = js.retain(new js.Proxy(kinetic.Stage, 
          js.map({'container': canvasId, 'width': canvasSize.width, 'height': canvasSize.height})));
    });
  }
  
  void addScreen(GameScreen screenToAdd)
  {
    js.scoped(() {
      _stage.add(screenToAdd.layer);
    });
    
    screenToAdd.screenManager = this;
    screens.add(screenToAdd);
  }
  
  void removeScreen(GameScreen screenToRemove)
  {
    screens.removeAt(screens.indexOf(screenToRemove));
  }
  
  void update(GameLoop gameLoop)
  {
    for (var screen in screens)
    {
      screen.update(gameLoop);
    }
  }
  
  void draw()
  {
    for(var screen in screens)
    {
      screen.draw();
    }
  }
  
  void setScreen(GameScreen screen)
  {
    js.scoped(() {
      _stage.clear();
    });
    
    screens.clear();
    addScreen(screen);
  }
}
