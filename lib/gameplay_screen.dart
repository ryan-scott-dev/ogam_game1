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
  static final int NodePadding = 10;
  
  GameplayScreen()
  {
    var worldSize = new Size(width: 640, height: 480);
    var nodeScale = 0.5;
    
    var rnf = new Random();
    
    for (var i = 0; i < 10; i++)
    {
      
      var node = new FortNode();
      node.scale = new Size(width: nodeScale, height: nodeScale);
      var nodeSize = node.size;
      
      var isPosValid = false;
      var nodePos = new vec2(0, 0);
      
      while(!isPosValid)
      {
        var xPos = inRange(rnf, nodeSize.width / 2, worldSize.width - nodeSize.width);
        var yPos = inRange(rnf, nodeSize.height / 2, worldSize.height - nodeSize.height);
      
        nodePos = new vec2(xPos, yPos);
        
        isPosValid = elements.every((element) => 
                      distance(nodePos, element.pos) > nodeSize.width + NodePadding);
        
      }
      
      node.pos = nodePos;
      
      addScreenElement(node);
    }
  }
  
  num inRange(Random rng, num min, num max)
  {
    return (max - min + 1) * rng.nextDouble() + min;
  }
}
