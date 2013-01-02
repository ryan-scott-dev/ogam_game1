library gameplay_screen;

import 'dart:html';
import 'dart:math';

import 'package:game_loop/game_loop.dart';
import 'package:vector_math/vector_math_browser.dart';

import 'size.dart';
import 'game_screen.dart';
import 'screen_manager.dart';
import 'fort_node.dart';

class GameplayScreen extends GameScreen
{
  GameplayScreen()
  {
    var worldSize = new Size(width: 640, height: 480);
    
    var rnf = new Random();
    
    for (var i = 0; i < 10; i++)
    {
      var xPos = rnf.nextInt(worldSize.width);
      var yPos = rnf.nextInt(worldSize.height);
      
      var node = new FortNode();
      node.pos = new vec2(xPos, yPos);
      node.scale = new Size(width: 0.5, height: 0.5);
      
      addScreenElement(node);
    }
  }
}
