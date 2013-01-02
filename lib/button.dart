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

typedef void ButtonClickCallback(Button button);

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
      
      shape.on('click', new js.Callback.many((event) {
        click();
      }));
    });
  }
  
  void update(GameLoop gameLoop)
  {
  }
  
  void click()
  {
    _callback(this);
  }
}
