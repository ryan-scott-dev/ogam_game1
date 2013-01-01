library home_screen;

import 'package:game_loop/game_loop.dart';
import 'package:vector_math/vector_math_browser.dart';

import 'game_screen.dart';
import 'screen_manager.dart';
import 'button.dart';

class HomeScreen extends GameScreen 
{
  HomeScreen()
  {
    var new_game_button = new Button(new vec2(100, 100), "new_game.png", 
        (button, gameLoop) => showGame()); 
    
    addScreenElement(new_game_button);
    
    var about_button = new Button(new vec2(100, 200), "about.png", 
        (button, gameLoop) => showAbout()); 
    
    addScreenElement(about_button);
  }
  
  void showGame()
  {
    print("Now showing game");
  }
  
  void showAbout()
  {
    print("Now showing about");
  }
}
