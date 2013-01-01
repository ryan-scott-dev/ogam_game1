library button;

import 'dart:html';
import 'package:game_loop/game_loop.dart';
import 'package:vector_math/vector_math_browser.dart';

import 'screen_element.dart';
import 'texture.dart';
import 'texture_manager.dart';

typedef void ButtonClickCallback(Button button, GameLoop gameLoop);

class Button extends ScreenElement {
  Texture _currentTexture;
  
  ButtonClickCallback _callback;
  
  Button(vec2 pos, String texturePath, ButtonClickCallback callback)
  {
    this.pos = pos;
    
    _callback = callback;
    _currentTexture = TextureManager.get(texturePath);
  }
  
  void draw(CanvasRenderingContext2D renderContext)
  {
    _currentTexture.draw(renderContext, pos);
  }
  
  void update(GameLoop gameLoop)
  {
    if(isWithin(gameLoop.mouse.x, gameLoop.mouse.y))
    {
      document.body.style.cursor = "pointer";  
      
      if(gameLoop.mouse.pressed(GameLoopMouse.LEFT))
        click(gameLoop);
    }
  }
  
  bool isWithin(int x, int y)
  {
    return x >= pos.x && x <= pos.x + _currentTexture.image.width &&
        y >= pos.y && y <= pos.y + _currentTexture.image.height;
  }
  
  void click(GameLoop gameLoop)
  {
    _callback(this, gameLoop);
  }
}
