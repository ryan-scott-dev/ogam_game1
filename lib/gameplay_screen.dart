library gameplay_screen;

import 'dart:html';
import 'dart:math';

import 'package:game_loop/game_loop.dart';
import 'package:vector_math/vector_math_browser.dart';

import 'size.dart';
import 'game_screen.dart';
import 'screen_manager.dart';
import 'fort_node.dart';
import 'player.dart';
import 'background.dart';
import 'image_screen_element.dart';
import 'texture_manager.dart';
import 'text_element.dart';
import 'button.dart';

class GameplayScreen extends GameScreen
{
  static final int NodePadding = 10;
  final List<FortNode> forts = new List<FortNode>();
  bool running = true;
  
  GameplayScreen(ScreenManager screenManager) 
    : super(screenManager)
  {
    Player.setup(this);
      
    setupWorld();
    
    var background = new ImageScreenElement(TextureManager.get('background.png'), this);
    addScreenElement(background);
    background.moveToBottom();
  }
  
  void setupWorld()
  {
    for(FortNode fort in forts)
    {
      removeElement(fort);
    }
    forts.clear();
    
    var worldSize = new Size(width: 640, height: 480);
    var nodeScale = 0.5;
    
    var rnf = new Random();
    
    for (var i = 0; i < 10; i++)
    {
      var node = new FortNode(this);
      node.scale = new Size(width: nodeScale, height: nodeScale);
      var nodeSize = node.size;
      
      var isPosValid = false;
      var nodePos = new vec2(0, 0);
      
      // Make sure that the node isn't overlapping any other nodes
      
      while(!isPosValid)
      {
        var xPos = inRange(rnf, nodeSize.width / 2, worldSize.width - nodeSize.width);
        var yPos = inRange(rnf, nodeSize.height / 2, worldSize.height - nodeSize.height);
      
        nodePos = new vec2(xPos, yPos);
        
        isPosValid = forts.every((element) => 
                      distance(nodePos, element.pos) > nodeSize.width + NodePadding);
        
      }
      
      node.pos = nodePos;
      
      forts.add(node);
      addScreenElement(node);
    }
    
    // Link the forts together with paths
    for (var fort in forts)
    {
      // Create the paths between nodes
      forts.sort((a,b) => distance(a.pos, fort.pos).compareTo(distance(b.pos, fort.pos)));
      
      var numberOfNeighbours = inRange(rnf, 2, 3).toInt();
      var neighbourCount = 0;
      var neighbours = forts.filter((element) => element != fort && neighbourCount++ < numberOfNeighbours);
      
      fort.addNeighbours(neighbours);
    }
    
    var orphanForts = forts.filter((fort) => fort.neighbours.length == 0);
    
    // Prune the orphan nodes
    for (var fort in orphanForts)
    {
      forts.removeAt(forts.indexOf(fort));
      removeElement(fort);
    }
    
    var prunedFortCount = orphanForts.length; 
    print("Pruned $prunedFortCount forts.");
    
    // Assign player fort
    var player = Player.get(Player.PLAYER);
    var playerFortId = inRange(rnf, 0, forts.length - 1);
    
    forts[playerFortId.toInt()].changePlayer(player);
    
    // Assign enemy fort
    var enemy = Player.get(Player.ENEMY);
    var enemyFortId = inRange(rnf, 0, forts.length - 1);
    
    while (enemyFortId == playerFortId)
    {
      enemyFortId = inRange(rnf, 0, forts.length - 1);
    }
    
    forts[enemyFortId.toInt()].changePlayer(enemy);
  }
  
  void update(GameLoop gameLoop)
  {
    var playerForts = forts.filter((fort) => fort.player == Player.CurrentPlayer); 
    var enemyForts = forts.filter((fort) => fort.player == Player.EnemyPlayer);
    
    if(running)
    {
      if(playerForts.length == 0)
      {
        displayGameOver();
      }
      else if(enemyForts.length == 0)
      {
        displayVictory();  
      }
      else
      {
        super.update(gameLoop);
      }
    }
  }
  
  void displayGameOver()
  {
    running = false;
    print("Game Over!");
    
    var text = new TextElement(this, "Game Over");
    text.fontSize = 72;
    text.pos = new vec2(screenManager.screenWidth / 2.0 - text.size.width / 2.0, 100);
    
    addScreenElement(text);
    
    var new_game_button = new Button(new vec2(0, 200), "new_game.png", 
        (button) => restart(), this); 
    new_game_button.scale = new Size(width: 0.5, height: 0.5);
    new_game_button.pos = new vec2(screenManager.screenWidth / 2.0 - new_game_button.size.width / 2.0, 
                                   screenManager.screenHeight / 2.0 - new_game_button.size.height / 2.0);
    addScreenElement(new_game_button);
  }
 
  void displayVictory()
  {
    running = false;
    print("You have won!");
    
    var text = new TextElement(this, "You won!");
    text.fontSize = 72;
    text.pos = new vec2(screenManager.screenWidth / 2.0 - text.size.width / 2.0, 100);
    addScreenElement(text);
    
    var new_game_button = new Button(new vec2(0, 200), "new_game.png", 
        (button) => restart(), this); 
    new_game_button.scale = new Size(width: 0.5, height: 0.5);
    new_game_button.pos = new vec2(screenManager.screenWidth / 2.0 - new_game_button.size.width / 2.0, 
                                   screenManager.screenHeight / 2.0 - new_game_button.size.height / 2.0);
    addScreenElement(new_game_button);
  }
  
  void restart()
  {
    screenManager.setScreen(new GameplayScreen(screenManager));
  }
  
  num inRange(Random rng, num min, num max)
  {
    return (max - min + 1) * rng.nextDouble() + min;
  }
}
