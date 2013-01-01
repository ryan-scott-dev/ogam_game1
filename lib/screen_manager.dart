library screen_manager;

import 'dart:html';
import 'package:game_loop/game_loop.dart';

import 'game_screen.dart';

class ScreenManager {
  List<GameScreen> _screens = new List<GameScreen>(); 
  List<GameScreen> get screens => _screens;
  
  void addScreen(GameScreen screenToAdd)
  {
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
  
  void draw(CanvasRenderingContext2D renderContext)
  {
    for(var screen in screens)
    {
      screen.draw(renderContext);
    }
  }
  
  void setScreen(GameScreen screen)
  {
    screens.clear();
    screens.add(screen);
  }
}
