library fort_node;

import 'dart:html';
import 'package:game_loop/game_loop.dart';
import 'package:vector_math/vector_math_browser.dart';

import 'game_screen.dart';
import 'texture_manager.dart';
import 'texture.dart';
import 'image_screen_element.dart';
import 'size.dart';
import 'fort_path.dart';

class FortNode extends ImageScreenElement 
{
  final List<FortPath> neighbours = new List<FortPath>();
  
  Size get size => new Size(width: texture.image.width * scale.width, 
                            height: texture.image.height * scale.height);
  vec2 get center => new vec2(pos.x + size.width / 2.0, pos.y + size.height / 2.0);
  
  FortNode(GameScreen gameScreen) : super(TextureManager.get('node.png'), gameScreen);
  
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
