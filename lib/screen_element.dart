library screen_element;

import 'dart:html';
import 'package:game_loop/game_loop.dart';
import 'package:vector_math/vector_math_browser.dart';

import 'game_screen.dart';

abstract class ScreenElement {
  GameScreen _screen;
  GameScreen get screen => _screen;
  
  vec2 pos;
  
  void draw(CanvasRenderingContext2D renderContext);
  void update(GameLoop gameLoop);
}
