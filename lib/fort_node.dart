library fort_node;

import 'dart:html';
import 'package:game_loop/game_loop.dart';
import 'package:vector_math/vector_math_browser.dart';

import 'texture_manager.dart';
import 'texture.dart';
import 'screen_element.dart';
import 'size.dart';
import 'fort_path.dart';

class FortNode extends ScreenElement 
{
  final List<FortPath> neighbours = new List<FortPath>();
  
  Texture _texture;
  
  Size get size => new Size(width: _texture.image.width * scale.width, 
                            height: _texture.image.height * scale.height);
  vec2 get center => new vec2(pos.x + size.width / 2.0, pos.y + size.height / 2.0);
  
  FortNode()
  {
    _texture = TextureManager.get('node.png');  
  }
  
  void draw(CanvasRenderingContext2D renderContext)
  {
    _texture.draw(renderContext, pos, scale: scale);
    
    // Check against one of the sides, to prevent double rendering a path
    for(var path in neighbours.filter((path) => path.nodeA == this))
    {
       path.draw(renderContext);
    }
  }
  
  void update(GameLoop gameLoop)
  {
    
  }
  
  void addNeighbour(FortNode newNeighbour)
  {
    if(neighbours.every((path) => !path.hasNode(newNeighbour)))
      neighbours.add(new FortPath(this, newNeighbour));
  }
  
  void addNeighbours(Collection<FortNode> newNeighbours)
  {
    for(var neighbour in newNeighbours)
    {
      addNeighbour(neighbour);
      neighbour.addNeighbour(this);
    }
  }
}
