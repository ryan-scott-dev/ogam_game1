library image_screen_element;

import 'screen_element.dart';
import 'package:js/js.dart' as js;
import 'package:vector_math/vector_math_browser.dart';

import 'game_screen.dart';
import 'texture.dart';
import 'size.dart';

abstract class ImageScreenElement extends ScreenElement {
  
  Texture _texture;
  Texture get texture => _texture;
  
  Size get size => new Size(width: texture.image.width * scale.width, 
      height: texture.image.height * scale.height);
  
  vec2 get center => new vec2(pos.x + size.width / 2.0, pos.y + size.height / 2.0);
  
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
