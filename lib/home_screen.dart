library home_screen;

import 'package:game_loop/game_loop.dart';
import 'package:vector_math/vector_math_browser.dart';

import 'game_screen.dart';
import 'screen_manager.dart';
import 'new_game_button.dart';

class HomeScreen extends GameScreen 
{

  HomeScreen()
  {
    var new_game_button = new NewGameButton(new vec2(100, 100));  
    addScreenElement(new_game_button);
  }
  
}
