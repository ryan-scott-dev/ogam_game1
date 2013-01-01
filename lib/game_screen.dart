library game_screen;

import 'dart:html';
import 'package:game_loop/game_loop.dart';

import 'screen_manager.dart';
import 'screen_element.dart';

class GameScreen {
  ScreenManager _screenManager;
  ScreenManager get screenManager => _screenManager;
  
  void update(GameLoop gameLoop)
  {
    updateElements(gameLoop);
  }
  
  void draw(CanvasRenderingContext2D renderContext)
  {
    drawElements(renderContext);
  }
  
  void exit()
  {
    screenManager.removeScreen(this);
  }
  
  List<ScreenElement> _elements = new List<ScreenElement>(); 
  List<ScreenElement> get elements => _elements;
  
  void addScreenElement(ScreenElement elementToAdd)
  {
    elements.add(elementToAdd);
  }
  
  void removeElement(ScreenElement elementToRemove)
  {
    elements.removeAt(elements.indexOf(elementToRemove));
  }
  
  void updateElements(GameLoop gameLoop)
  {
    for (var element in elements)
    {
      element.update(gameLoop);
    }
  }
  
  void drawElements(CanvasRenderingContext2D renderContext)
  {
    for(var element in elements)
    {
      element.draw(renderContext);
    }
  }
}
