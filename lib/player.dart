library player;

import 'dart:html';
import 'package:game_loop/game_loop.dart';
import 'package:vector_math/vector_math_browser.dart';
import 'package:js/js.dart' as js;

import 'screen_element.dart';
import 'fort_node.dart';
import 'gameplay_screen.dart';
import 'texture_manager.dart';
import 'enemy.dart';

class Player extends ScreenElement {
  
  static Map<num, Player> players = new Map<int, Player>();
  
  static Player CurrentPlayer;
  static Player NeutralPlayer;
  static Player EnemyPlayer;
  
  static const num NEUTRAL = 0;
  static const num PLAYER = 1;
  static const num ENEMY = 2;
  
  num playerId;
  
  bool get isNeutral => playerId == Player.NEUTRAL;
  bool get isCurrent => playerId == Player.PLAYER;
  
  FortNode target;
  js.Proxy _targetImage;
  
  Player(this.playerId, GameplayScreen gameScreen) 
    : super(gameScreen)
  {
    players[this.playerId] = this;
    
    var texture = TextureManager.get('order.png');
    
    js.scoped(() {
      var kinetic = js.context.Kinetic;
      _targetImage = js.retain(new js.Proxy(kinetic.Image, js.map({
          'image': texture.image,
          'scale': 0.5
          })
        ));
      
      screen.layer.add(_targetImage);
      
      _targetImage.hide();
    });
    
    gameScreen.addScreenElement(this);
  }
  
  String getPlayerImage()
  {
    switch(playerId)
    {
      case NEUTRAL:
        return 'node_neutral.png';
      case PLAYER:
        return 'node_player.png';
      case ENEMY:
        return 'node_enemy.png';
    }
  }
  
  void setTarget(FortNode node)
  {
    target = node;
    this.dirty = true;
  }
  
  void resetTarget()
  {
    setTarget(null);
  }
  
  void update(GameLoop gameLoop)
  {
  }
  
  void draw()
  {
    js.scoped(() {
      if (target != null)
      {
        _targetImage.show();
        _targetImage.moveToTop();
        _targetImage.setPosition(target.center.x - _targetImage.getWidth() * _targetImage.getScale().x * 0.5, 
                                 target.pos.y - _targetImage.getHeight() * _targetImage.getScale().y * 0.75);
      }
      else
      {
        _targetImage.hide();
      }
     });
  }
  
  static void setup(GameplayScreen gameScreen)
  {
    NeutralPlayer = new Player(Player.NEUTRAL, gameScreen);
    CurrentPlayer = new Player(Player.PLAYER, gameScreen);
    EnemyPlayer = new Enemy(gameScreen);
  }
  
  static Player get(num playerId)
  {
    return players[playerId];
  }
}
