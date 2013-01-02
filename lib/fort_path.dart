library fort_path;

import 'dart:html';
import 'fort_node.dart';

class FortPath {
    FortNode nodeA, nodeB;
    
    FortPath(this.nodeA, this.nodeB);
    
    bool hasNode(FortNode node)
    {
      return nodeA == node || nodeB == node;
    }
    
    void draw(CanvasRenderingContext2D renderContext)
    {
      renderContext.beginPath();
      renderContext.moveTo(nodeA.center.x, nodeA.center.y);
      
      renderContext.lineTo(nodeB.center.x, nodeB.center.y);
      
      renderContext.closePath();
      renderContext.stroke();
    }
}
