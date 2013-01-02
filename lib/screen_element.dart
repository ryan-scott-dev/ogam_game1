library screen_element;

import 'dart:html';
import 'package:game_loop/game_loop.dart';
import 'package:vector_math/vector_math_browser.dart';
import 'package:js/js.dart' as js;

import 'game_screen.dart';
import 'size.dart';

abstract class ScreenElement {
  GameScreen _screen;
  GameScreen get screen => _screen;
  
  vec2 pos;
  Size scale;
  
  void draw(CanvasRenderingContext2D renderContext);
  void update(GameLoop gameLoop);
}
