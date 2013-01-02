library texture;

import 'dart:html';
import 'package:vector_math/vector_math_browser.dart';

import 'size.dart';

class Texture {
  final String name;
  final ImageElement image;  
  
  bool loaded = false; 
  
  Texture(this.name, this.image);
  
  void draw(CanvasRenderingContext2D renderContext, vec2 pos, {Size scale})
  {
    if(scale == null)
      scale = new Size(width: 1, height: 1);
    
    renderContext.drawImage(image, pos.x, pos.y, image.width * scale.width, image.height * scale.height);
  }
}
