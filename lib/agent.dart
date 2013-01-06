library agent;

import 'dart:html';
import 'package:game_loop/game_loop.dart';
import 'package:vector_math/vector_math_browser.dart';
import 'package:js/js.dart' as js;

import 'fort_node.dart';
import 'fort_path.dart';
import 'screen_element.dart';
import 'game_screen.dart';
import 'image_screen_element.dart';
import 'texture_manager.dart';
import 'player.dart';

class Agent extends ImageScreenElement {
  static const num MOVE_SPEED = 1;
  static const num NODE_DISTANCE = 20;
  
  FortNode home, target;
  FortPath _path;
  Player owner;
  
  bool get isMoving => _path != null;
  bool get isAttacking => this.target != null && this.target.player != owner;
      
  Agent(this.home, GameScreen gameScreen) 
    : super(TextureManager.get('agent.png'), gameScreen)
  {    
    this.pos = this.home.pos;
    this.owner = this.home.player;
  }
  
  void marchTowards(FortPath path)
  {
    this._path = path;
    this.target = _path.nodeA != this.home ? _path.nodeA : _path.nodeB;
  }
  
  void draw()
  {
  }
  
  void update(GameLoop gameLoop)
  {
    js.scoped(() {
      if(isMoving)
      {
        if(!shape.isVisible())
        {
          shape.show();  
        }
        
        var direction = normalize(this.target.center - this.center);
        var offset = direction * MOVE_SPEED * gameLoop.dt;
        
        shape.move(offset.x, offset.y);
        
        var updatedPosition = this.center;
        if(distance(updatedPosition, this.target.center) < NODE_DISTANCE)
        {
          if(isAttacking)
          {
            this.target.attack(this);
            this.home.removeUnit(this);
            this.screen.removeElement(this);
          }
          else if(this.target.canAcceptUnits())
          { 
            this.home.removeUnit(this);
            this.target.addUnit(this);
            
            this.home = this.target;
            this._path = null;
          }
          else
          {
            this.home.removeUnit(this);
            this.target.addUnit(this);
            
            var tempTarget = this.target;
            this.target = this.home;
            this.home = tempTarget;
          }
        }
        
        this.dirty = true;
      }
      
      if(!isMoving && !isAttacking && shape.isVisible())
      {
        shape.hide();
      }
    });
  }
}
