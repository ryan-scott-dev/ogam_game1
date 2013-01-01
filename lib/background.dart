library background;

import 'dart:html';
import 'dart:svg';

import 'package:game_loop/game_loop.dart';

import 'screen_element.dart';

class Background extends ScreenElement {
  String fill;
  
  Background(this.fill);
  
  void draw(CanvasRenderingContext2D renderContext)
  {
    renderContext.fillStyle = fill;
    renderContext.fillRect(0, 0, renderContext.canvas.clientWidth, 
        renderContext.canvas.clientHeight);
  }
  
  void update(GameLoop gameLoop)
  {
  }
}
