library fort_node;

import 'dart:html';
import 'package:game_loop/game_loop.dart';
import 'package:vector_math/vector_math_browser.dart';
import 'package:js/js.dart' as js;

import 'game_screen.dart';
import 'texture_manager.dart';
import 'texture.dart';
import 'image_screen_element.dart';
import 'size.dart';
import 'fort_path.dart';
import 'player.dart';
import 'button.dart';
import 'agent.dart';

class FortNode extends Button 
{
  final List<FortPath> neighbours = new List<FortPath>();
  final List<Agent> units = new List<Agent>();
  
  Size get size => new Size(width: texture.image.width * scale.width, 
                            height: texture.image.height * scale.height);
  vec2 get center => new vec2(pos.x + size.width / 2.0, pos.y + size.height / 2.0);
  
  int get unitCount => units.length;
  
  Player _player;
  js.Proxy _textShape;
  
  FortNode(GameScreen gameScreen) 
    : super(new vec2(0, 0), 'node_neutral.png', null, gameScreen)
  {
     changePlayer(Player.get(Player.NEUTRAL)); 
     setCallback(onClick);
     
     js.scoped(() {
       var kinetic = js.context.Kinetic;
       _textShape = js.retain(new js.Proxy(kinetic.Text, js.map({
         'text': 'test',
         'fontSize': 24,
         'textFill': '#E7F2DF',
         'textShadow': {
           'color': '#555',
           'blur': 1,
           'offset': [1, 1],
           'opacity': 0.7},
         }
       )));
       
       screen.layer.add(_textShape);
     });
  }
  
  void draw()
  {
    js.scoped(() {
      _textShape.setText(unitCount.toString());
      _textShape.setPosition(center.x - _textShape.getWidth() / 2.0, center.y - _textShape.getHeight() / 2.0);
    });
  }
  
  void update(GameLoop gameLoop)
  {
  }
  
  void onClick(Button button)
  {
    print("Clicked a fort node");
  }
  
  void changePlayer(Player newPlayer)
  {
    _player = newPlayer;
    
    js.scoped(() {
      shape.setImage(TextureManager.get(newPlayer.getPlayerImage()).image);
    });
  }
  
  void addNeighbour(FortNode newNeighbour)
  {
    if(neighbours.every((path) => !path.hasNode(newNeighbour)))
      neighbours.add(new FortPath(this, newNeighbour, screen));
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
