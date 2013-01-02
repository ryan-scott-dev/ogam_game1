library fort_node;

import 'dart:html';
import 'package:game_loop/game_loop.dart';
import 'package:vector_math/vector_math_browser.dart';

import 'texture_manager.dart';
import 'texture.dart';
import 'screen_element.dart';
import 'size.dart';

class FortNode extends ScreenElement 
{
  Texture _texture;
  
  Size get size => new Size(width: _texture.image.width * scale.width, 
                            height: _texture.image.height * scale.height);
  
  FortNode()
  {
    _texture = TextureManager.get('node.png');  
  }
  
  void draw(CanvasRenderingContext2D renderContext)
  {
    _texture.draw(renderContext, pos, scale: scale);
  }
  
  void update(GameLoop gameLoop)
  {
    
  }
}
