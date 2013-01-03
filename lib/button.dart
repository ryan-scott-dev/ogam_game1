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
  js.Callback _mouseOverCallback;
  js.Callback _mouseOutCallback;
  js.Callback _clickCallback;
  
  Button(vec2 pos, String texturePath, ButtonClickCallback callback, GameScreen gameScreen) 
    : super(TextureManager.get(texturePath), gameScreen)
  {
    this.pos = pos;
    
    _callback = callback;
    
    js.scoped(() {
      _mouseOverCallback = new js.Callback.many((event) {
        document.body.style.cursor = 'pointer';
      });
      _mouseOutCallback = new js.Callback.many((event) {
        document.body.style.cursor = 'default';
      });
      _clickCallback = new js.Callback.many((event) {
        click();
      });
      
      shape.on('mouseover', _mouseOverCallback);
      shape.on('mouseout', _mouseOutCallback);
      shape.on('click', _clickCallback);
      shape.on('tap', _clickCallback);
    });
  }
  
  void update(GameLoop gameLoop)
  {
  }
  
  void setCallback(ButtonClickCallback newCallback)
  {
    _callback = newCallback;
  }
  
  void click()
  {
    _callback(this);
  }
  
  void cleanup()
  {
    js.scoped(() {
      shape.off('mouseover');
      shape.off('mouseout');
      shape.off('click');
      shape.off('tap');
      
      _mouseOverCallback.dispose();
      _mouseOutCallback.dispose();
      _clickCallback.dispose();
    });
    
    super.cleanup();
  }
}
