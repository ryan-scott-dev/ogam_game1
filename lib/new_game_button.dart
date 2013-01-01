library new_game_button;

import 'dart:html';
import 'package:game_loop/game_loop.dart';
import 'package:vector_math/vector_math_browser.dart';

import 'screen_element.dart';
import 'texture.dart';
import 'texture_manager.dart';

class NewGameButton extends ScreenElement {
  Texture _currentTexture;
  
  NewGameButton(vec2 pos)
  {
    this.pos = pos;
    _currentTexture = TextureManager.get("new_game.png");
  }
  
  void draw(CanvasRenderingContext2D renderContext)
  {
    _currentTexture.draw(renderContext, pos);
  }
  
  void update(GameLoop gameLoop)
  {
    if (isWithin(gameLoop.mouse.x, gameLoop.mouse.y))
    {
      document.body.style.cursor = "pointer";  
    }
    else
    {
      document.body.style.cursor = "default";
    }
    
  }
  
  bool isWithin(int x, int y)
  {
    return x >= pos.x && x <= pos.x + _currentTexture.image.width &&
        y >= pos.y && y <= pos.y + _currentTexture.image.height;
  }
}
