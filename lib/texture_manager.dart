library texture_manager;

import 'dart:html';
import 'texture.dart';

class TextureManager {
  static Map<String, Texture> _textures = new Map<String, Texture>();
  static List<Texture> _texturesLoading = new List<Texture>();
  static Function onLoadComplete;
  
  static Texture get(String textureName)
  {
    return _textures[textureName];
  }
  
  static void load(String textureName, {void callback(String textureName): null})
  {
    ImageElement img = new ImageElement(src: "images\\$textureName");
    var texture = new Texture(textureName, img);
    
    _textures[textureName] = texture;
    _texturesLoading.add(texture);
    
    img.on.load.add((event) {
      if(callback != null)
        callback(textureName);
      
      _texturesLoading.removeAt(_texturesLoading.indexOf(texture));
      if(_texturesLoading.length == 0)
      {    
        onLoadComplete();
      }
    });
  }
}
