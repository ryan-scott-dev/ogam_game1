library texture;

import 'dart:html';
import 'package:vector_math/vector_math_browser.dart';

import 'size.dart';

typedef TextureLoadDelegate(Texture texture);

class Texture {
  final String name;
  final ImageElement image;  
  final List<TextureLoadDelegate> onLoadCallbacks = new List<TextureLoadDelegate>();
  
  bool loaded = false; 
  
  Texture(this.name, this.image)
  {
    this.image.on.load.add((event) => this.runLoadCallbacks());
  }
  
  void draw(CanvasRenderingContext2D renderContext, vec2 pos, {Size scale})
  {
    if(scale == null)
      scale = new Size(width: 1, height: 1);
    
    renderContext.drawImage(image, pos.x, pos.y, image.width * scale.width, image.height * scale.height);
  }
  
  void runLoadCallbacks()
  {
    loaded = true;
    
    for(var callback in onLoadCallbacks)
    {
      callback(this);
    }
    
    onLoadCallbacks.clear();
  }
  
  void onLoad(TextureLoadDelegate callback)
  {
    if(loaded)
    {
      callback(this);
      return;
    }
    
    onLoadCallbacks.add(callback);
  }
}
