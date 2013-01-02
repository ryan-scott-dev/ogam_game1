library screen_element;

import 'dart:html';
import 'package:game_loop/game_loop.dart';
import 'package:vector_math/vector_math_browser.dart';
import 'package:js/js.dart' as js;

import 'game_screen.dart';
import 'size.dart';

abstract class ScreenElement {
  js.Proxy shape;
  bool dirty = true;
  
  GameScreen _screen;
  GameScreen get screen => _screen;
  
  ScreenElement(this._screen);
  
  vec2 get pos => js.scoped(() {return new vec2(shape.getX(), shape.getY());});
       set pos(value) => js.scoped(() {
         shape.setPosition(value.x, value.y);
         dirty = true;
       });  
       
  Size get scale => js.scoped(() {return new Size(width: shape.getScale().x, height: shape.getScale().y);});
       set scale(value) => js.scoped(() {
         shape.setScale(value.width, value.height);
         dirty = true;
       });  
  
  void draw();
  void update(GameLoop gameLoop);
  
  void cleanup()
  {
  }
  
  void moveToTop()
  {
    js.scoped(() {
      shape.moveToTop();
      dirty = true;
    });  
  }
  
  void moveToBottom()
  {
    js.scoped(() {
      shape.moveToBottom();
      dirty = true;
    }); 
  }
  
  void setLayer(num layer)
  {
    js.scoped(() {
      shape.setZIndex(layer);
      dirty = true;
    }); 
  }
}
