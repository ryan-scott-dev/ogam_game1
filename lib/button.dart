library button;

import 'dart:html';
import 'package:game_loop/game_loop.dart';
import 'package:vector_math/vector_math_browser.dart';
import 'package:js/js.dart' as js;

import 'screen_element.dart';
import 'texture.dart';
import 'texture_manager.dart';
import 'image_screen_element.dart';
import 'game_screen.dart';

typedef void ButtonClickCallback(Button button, GameLoop gameLoop);

class Button extends ImageScreenElement {
  ButtonClickCallback _callback;
  
  Button(vec2 pos, String texturePath, ButtonClickCallback callback, GameScreen gameScreen) 
  : super(TextureManager.get(texturePath), gameScreen)
  {
    this.pos = pos;
    
    _callback = callback;
    
    js.scoped(() {
      shape.on('mouseover', new js.Callback.many((event) {
        document.body.style.cursor = 'pointer';
      }));
      
      shape.on('mouseout', new js.Callback.many((event) {
        document.body.style.cursor = 'default';
      }));
    });
  }
  
  void update(GameLoop gameLoop)
  {
    if(isWithin(gameLoop.mouse.x, gameLoop.mouse.y))
    {
      if(gameLoop.mouse.pressed(GameLoopMouse.LEFT))
        click(gameLoop);
    }
  }
  
  bool isWithin(int x, int y)
  {
    return x >= pos.x && x <= pos.x + texture.image.width &&
        y >= pos.y && y <= pos.y + texture.image.height;
  }
  
  void click(GameLoop gameLoop)
  {
    _callback(this, gameLoop);
  }
}
