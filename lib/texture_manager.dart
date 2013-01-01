library texture_manager;

import 'dart:html';
import 'texture.dart';

class TextureManager {
  static Map<String, Texture> _textures = new Map<String, Texture>();
  
  static Texture get(String textureName)
  {
    return _textures[textureName];
  }
  
  static void load(String textureName)
  {
    ImageElement img = new ImageElement(src: "images\\$textureName");
    var texture = new Texture(textureName, img);
    _textures.putIfAbsent(textureName, () => texture);
    
    img.on.load.add((event) {
      print("Loaded $textureName");
      
      texture.loaded = true;  
    });
  }
}
