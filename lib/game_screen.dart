library game_screen;

import 'dart:html';
import 'package:game_loop/game_loop.dart';
import 'package:js/js.dart' as js;

import 'screen_manager.dart';
import 'screen_element.dart';

class GameScreen {
  num get width => screenManager.screenWidth;
  num get height => screenManager.screenHeight;
  
  ScreenManager screenManager;
  js.Proxy _layer;
  js.Proxy get layer => _layer;
  
  bool dirty = true;
  
  GameScreen(ScreenManager screenManager)
  {
    this.screenManager = screenManager;
    
    js.scoped(() {
      var kinetic = js.context.Kinetic;
      _layer = js.retain(new js.Proxy(kinetic.Layer));
    });
  }
  
  void update(GameLoop gameLoop)
  {
    updateElements(gameLoop);
  }
  
  void draw()
  {
    if(elements.some((element) => element.dirty) || this.dirty)
    {
      for(var element in elements)
      {
        element.dirty = false;
      }
      
      this.dirty = false;
          
      drawElements();
      
      js.scoped(() {
        _layer.clear();
        _layer.draw();
      });
    }
  }
  
  void cleanup()
  {
    for(var element in elements)
    {
      element.cleanup();
    }   
    
    elements.clear();
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
    
    this.dirty = true;
    elementToRemove.cleanup();
    js.scoped(() {
      elementToRemove.shape.remove();
    });
  }
  
  void updateElements(GameLoop gameLoop)
  {
    for (var element in elements)
    {
      element.update(gameLoop);
    }
  }
  
  void drawElements()
  {
    for(var element in elements)
    {
      element.draw();
    }
  }
}
