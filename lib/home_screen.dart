library home_screen;

import 'dart:html';
import 'dart:svg';

import 'package:game_loop/game_loop.dart';
import 'package:vector_math/vector_math_browser.dart';

import 'game_screen.dart';
import 'screen_manager.dart';
import 'button.dart';
import 'background.dart';

import 'gameplay_screen.dart';
import 'about_screen.dart';

class HomeScreen extends GameScreen 
{
  HomeScreen(ScreenManager screenManager) : super(screenManager)
  {
    var background = new Background("#000000", this);
    addScreenElement(background);
    
    var new_game_button = new Button(new vec2(100, 100), "new_game.png", 
        (button, gameLoop) => showGame(), this); 
    
    addScreenElement(new_game_button);
    
    var about_button = new Button(new vec2(100, 220), "about.png", 
        (button, gameLoop) => showAbout(), this); 
    
    addScreenElement(about_button);
  }
  
  void showGame()
  {
    screenManager.setScreen(new GameplayScreen(screenManager));
    
    print("Now showing game");
  }
  
  void showAbout()
  {
    screenManager.setScreen(new AboutScreen(screenManager));
    
    print("Now showing about");
  }
}
