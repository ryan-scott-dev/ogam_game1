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
import 'image_screen_element.dart';
import 'texture_manager.dart';
import 'size.dart';

class HomeScreen extends GameScreen 
{
  HomeScreen(ScreenManager screenManager) : super(screenManager)
  {
    var background = new ImageScreenElement(TextureManager.get('background.png'), this);
    addScreenElement(background);
    background.moveToBottom();
    
    var new_game_button = new Button(new vec2(0, 200), "new_game.png", 
        (button) => showGame(), this); 
    new_game_button.scale = new Size(width: 0.5, height: 0.5);
    new_game_button.pos = new vec2(screenManager.screenWidth / 2.0 - new_game_button.size.width / 2.0, 
                                   screenManager.screenHeight / 2.0 - new_game_button.size.height / 2.0);
    
    addScreenElement(new_game_button);
    
    var heading = new ImageScreenElement(TextureManager.get('heading.png'), this);
    heading.pos = new vec2(screenManager.screenWidth / 2.0 - heading.size.width / 2.0, 150);
    
    addScreenElement(heading);
  }
  
  void showGame()
  {
    document.body.style.cursor = 'default';
    screenManager.setScreen(new GameplayScreen(screenManager));
    
    print("Now showing game");
  }
}
