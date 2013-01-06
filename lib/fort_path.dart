library fort_path;

import 'dart:html';
import 'package:game_loop/game_loop.dart';
import 'package:vector_math/vector_math_browser.dart';
import 'package:js/js.dart' as js;

import 'fort_node.dart';
import 'game_screen.dart';
import 'screen_element.dart';

class FortPath extends ScreenElement{
    FortNode nodeA, nodeB;
    
    FortPath(this.nodeA, this.nodeB, GameScreen screen) 
      : super(screen)
    {
        js.scoped(() {
          var kinetic = js.context.Kinetic;
          shape = js.retain(new js.Proxy(kinetic.Line, js.map({
            'points': js.array([nodeA.center.x, nodeA.center.y, nodeB.center.x, nodeB.center.y]),
            'stroke': '#9CA69D',
            'strokeWidth': 3}
          )));
          
          screen.layer.add(shape);
          
          shape.moveToBottom();
        });
    }
    
    bool hasNode(FortNode node)
    {
      return nodeA == node || nodeB == node;
    }
    
    FortNode alternateNode(FortNode node)
    {
      return node == nodeA ? nodeB : nodeA; 
    }
    
    void draw()
    {
    }
    
    void update(GameLoop gameLoop)
    {
    }
}
