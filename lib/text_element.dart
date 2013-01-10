library text_element;

import 'dart:html';
import 'package:game_loop/game_loop.dart';
import 'package:js/js.dart' as js;

import 'screen_element.dart';
import 'game_screen.dart';
import 'size.dart';

class TextElement extends ScreenElement {
  String text;
  
  Size get size => js.scoped(() {return new Size(width: shape.getWidth(), height: shape.getHeight());});
  set fontSize(num value) => js.scoped(() {
    shape.setFontSize(value);
    dirty = true;
  });  
  
  TextElement(GameScreen gameScreen, this.text) 
    : super(gameScreen)
  {
    js.scoped(() {
      var kinetic = js.context.Kinetic;
      shape = js.retain(new js.Proxy(kinetic.Text, js.map({
        'text': this.text,
        'fontSize': 12,
        'textFill': '#000',
        'padding': 20,
        'align': 'center',
        'textShadow': {
          'color': '#FFF',
          'blur': 1,
          'offset': [1, 1],
          'opacity': 0.7},
        }
      )));
      screen.layer.add(shape);
    });
    
    print('Text element of: $text');
  }
  
  void draw()
  { 
  }
  
  void update(GameLoop gameLoop)
  {
  }
}
