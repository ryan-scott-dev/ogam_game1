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
  final List<FortNode> forts = new List<FortNode>();
  
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
      
      // Make sure that the node isn't overlapping any other nodes
      
      while(!isPosValid)
      {
        var xPos = inRange(rnf, nodeSize.width / 2, worldSize.width - nodeSize.width);
        var yPos = inRange(rnf, nodeSize.height / 2, worldSize.height - nodeSize.height);
      
        nodePos = new vec2(xPos, yPos);
        
        isPosValid = forts.every((element) => 
                      distance(nodePos, element.pos) > nodeSize.width + NodePadding);
        
      }
      
      node.pos = nodePos;
      
      // Create the paths between nodes
      forts.sort((a,b) => distance(a.pos, node.pos).compareTo(distance(b.pos, node.pos)));
      
      var numberOfNeighbours = inRange(rnf, 1, 2).toInt();
      var neighbourCount = 0;
      var neighbours = forts.filter((element) => neighbourCount++ < numberOfNeighbours);
      
      node.addNeighbours(neighbours as Collection<FortNode>);
      
      forts.add(node);
      addScreenElement(node);
    }
  }
  
  num inRange(Random rng, num min, num max)
  {
    return (max - min + 1) * rng.nextDouble() + min;
  }
}
