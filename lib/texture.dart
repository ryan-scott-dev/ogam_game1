library texture;

import 'dart:html';
import 'package:vector_math/vector_math_browser.dart';

class Texture {
  final String name;
  final ImageElement image;  
  
  bool loaded = false; 
  
  Texture(this.name, this.image);
  
  void draw(CanvasRenderingContext2D renderContext, vec2 pos)
  {
    renderContext.drawImage(image, pos.x, pos.y, image.width, image.height);
  }
}
