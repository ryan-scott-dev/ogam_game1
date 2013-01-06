library enemy;

import 'dart:html';
import 'dart:math';

import 'package:game_loop/game_loop.dart';
import 'package:vector_math/vector_math_browser.dart';
import 'package:js/js.dart' as js;

import 'gameplay_screen.dart';
import 'player.dart';
import 'fort_node.dart';
import 'fort_path.dart';

class Enemy extends Player 
{
  num attackTimer = 0;
  num nextAttack = 0;
  
  GameplayScreen gameplayScreen;
  
  Enemy(GameplayScreen gameplayScreen) 
    : super(Player.ENEMY, gameplayScreen)
  {
      this.gameplayScreen = gameplayScreen;
  }
  
  void update(GameLoop gameLoop)
  {
    if(target == null)
    {
      var enemyForts = gameplayScreen.forts.filter((fort) => fort.player == this);
      var rnf = new Random();
      
      var counter = 3;
      while(target == null && counter > 0)
      {
        counter--;
        
        // Select a random fort that we already own
        var fortId = inRange(rnf, 0, enemyForts.length - 1);
        FortNode decisionFort = enemyForts[fortId.toInt()];
        
        var neighbourForts = decisionFort
            .neighbours.map((FortPath neighbour) => neighbour.alternateNode(decisionFort))
            .filter((FortNode node) => node.player != this);
        
        // Choose a random neighbour fort that we don't currently own
        if(neighbourForts.length > 0)
        {
          // Set that fort as our target
          var targetId = inRange(rnf, 0, neighbourForts.length - 1);
          FortNode newTarget = neighbourForts[targetId.toInt()];
          
          print("Enemy has found a target");
          
          this.setTarget(newTarget);
        }
      }
    }
  }
  
  num inRange(Random rng, num min, num max)
  {
    return (max - min + 1) * rng.nextDouble() + min;
  }
}
