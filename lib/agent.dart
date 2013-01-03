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

class Agent extends ImageScreenElement {
  static const num MOVE_SPEED = 1;
  static const num NODE_DISTANCE = 20;
  
  FortNode home, target;
  FortPath _path;
  
  bool get isMoving => _path != null;
  bool get isAttacking => this.home.isEnemyNode;
      
  Agent(this.home, GameScreen gameScreen) 
    : super(TextureManager.get('agent.png'), gameScreen)
  {    
    this.pos = this.home.pos;
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
      if(isMoving && !isAttacking)
      {
        if(!shape.isVisible())
        {
          shape.show();  
        }
        
        var direction = normalize(this.target.center - this.center);        
        var offset = direction * MOVE_SPEED * gameLoop.dt;
        
        shape.move(offset.x, offset.y);
        
        var updatedPosition = this.center;
        if(distance(updatedPosition, this.target.center) < NODE_DISTANCE){
          this.home.removeUnit(this);
          this.target.addUnit(this);
          
          this.home = this.target;
          this._path = null;
        }
        
        this.dirty = true;
      }
      
      if(isAttacking)
      {
        this.home.attack();
      }
      
      if(!isMoving && !isAttacking && shape.isVisible())
      {
        shape.hide();
      }
    });
  }
}
