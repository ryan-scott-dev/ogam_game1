library background;

import 'dart:html';
import 'dart:svg';
import 'package:js/js.dart' as js;

import 'package:game_loop/game_loop.dart';

import 'game_screen.dart';
import 'screen_element.dart';

class Background extends ScreenElement {
  String fill;
  js.Proxy _shape;
  
  Background(String fill, GameScreen gameScreen) : super(gameScreen) 
  {
    this.fill = fill;
    
    js.scoped(() {
      var kinetic = js.context.Kinetic;
      _shape = js.retain(new js.Proxy(kinetic.Rect, js.map({'fill': fill, 'x': 0, 'y': 0, 
        'width': gameScreen.width, 'height': gameScreen.height})));
      
      gameScreen.layer.add(_shape);
    });
  }
  
  void draw()
  {
  }
  
  void update(GameLoop gameLoop)
  {
  }
}
