library image_screen_element;

import 'screen_element.dart';
import 'package:js/js.dart' as js;

import 'game_screen.dart';
import 'texture.dart';

abstract class ImageScreenElement extends ScreenElement {
  
  Texture _texture;
  Texture get texture => _texture;
  
  ImageScreenElement(Texture texture, GameScreen gameScreen)  
    : super(gameScreen)
  {
    _texture = texture;
    _texture.onLoad(onTextureLoad);
  }
  
  void onTextureLoad(texture)
  {
    js.scoped(() {
      var kinetic = js.context.Kinetic;
      shape = js.retain(new js.Proxy(kinetic.Image, js.map({'image': texture.image})));
      screen.layer.add(shape);
    });
  }
  
  void draw()
  {
  }
}
