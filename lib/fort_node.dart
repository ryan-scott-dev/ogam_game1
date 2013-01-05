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
  static const MAX_UNITS = 5;
  static const UNIT_WAIT = 3;
  
  final List<FortPath> neighbours = new List<FortPath>();
  final List<Agent> units = new List<Agent>();
  
  int get unitCount => units.filter((unit) => !unit.isMoving).length;
  bool get isEnemyNode => !this.player.isCurrent;
  
  js.Proxy _textShape;
  
  Player player;
  num unitTimer = 0;
  
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
       
       _textShape.hide();
       
       screen.layer.add(_textShape);
     });
  }
  
  void draw()
  {
    js.scoped(() {
      _textShape.setText(unitCount.toString());
      _textShape.setPosition(center.x - _textShape.getWidth() / 2.0, center.y - _textShape.getHeight() / 2.0);
      
      if(player.isNeutral)
      {
        _textShape.hide();
      }
      else
      {
        _textShape.show();
      }
    });
  }
  
  void attack()
  {
    changePlayer(Player.CurrentPlayer);
    Player.CurrentPlayer.resetTarget();
  }
  
  void update(GameLoop gameLoop)
  {
    generateNewUnits(gameLoop);
    
    moveUnitsToNearbyTargets(gameLoop);
  }
  
  void moveUnitsToNearbyTargets(GameLoop gameLoop)
  {
    if(!player.isCurrent)
      return;
    
    if(player.target != null && isNeighbour(player.target))
    {
      var path = getNeighbour(player.target);
      
      var availableUnits = units.filter((unit) => !unit.isMoving).iterator();
      
      if(availableUnits.hasNext)
      {
        var availableUnit = availableUnits.next();
        
        if (availableUnit != null) 
          availableUnit.marchTowards(path);
      }
    }
  }
  
  bool isNeighbour(FortNode node)
  {
    return neighbours.some((path) => path.nodeA == node || path.nodeB == node);
  }
  
  FortPath getNeighbour(FortNode node)
  {
    return neighbours.filter((path) => path.nodeA == node || path.nodeB == node).iterator().next();
  }
  
  bool canAcceptUnits()
  {
    return unitCount < MAX_UNITS && !this.player.isNeutral;
  }
  
  void generateNewUnits(GameLoop gameLoop)
  {
    if(canAcceptUnits())
    {
      if(unitTimer < UNIT_WAIT)
      {
        unitTimer += gameLoop.dt;
      }
      else
      {
        unitTimer = 0;
        
        var newUnit = new Agent(this, screen);
        addUnit(newUnit);
        screen.addScreenElement(newUnit);
        
        this.dirty = true;
      }
    }
  }
  
  void addUnit(Agent agent)
  {
    units.add(agent);
  }
  
  void removeUnit(Agent agent)
  {
    units.removeAt(units.indexOf(agent));
  }
  
  void onClick(Button button)
  {
    Player.CurrentPlayer.setTarget(this);
  }
  
  void changePlayer(Player newPlayer)
  {
    player = newPlayer;
    
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
