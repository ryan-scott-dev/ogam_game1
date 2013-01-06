import 'dart:html';
import 'package:game_loop/game_loop.dart';
import 'package:js/js.dart' as js;

import '../lib/texture_manager.dart';
import '../lib/game.dart';
import '../lib/home_screen.dart';

void main() {

  var game = new Game();
  game.resources = {
                    'textures': ['new_game.png', 'about.png', 'node_neutral.png', 'node_player.png', 'node_enemy.png', 'agent.png', 'order.png'],
                    'audio' : ['test.ogg']
                   };
  game.start();
  
  game.onLoadComplete = () {
    game.screenManager.addScreen(new HomeScreen(game.screenManager));
  };
}