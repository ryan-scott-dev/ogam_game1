import 'dart:html';
import 'package:game_loop/game_loop.dart';

GameLoop gameLoop;

void update(GameLoop gameLoop) {
  bool mouseDown = gameLoop.mouse.isDown(GameLoopMouse.LEFT);
  
  if (mouseDown) {
    print('left down.');
  }
  
  bool down = gameLoop.keyboard.isDown(GameLoopKeyboard.D);
  double timePressed = gameLoop.keyboard.timePressed(GameLoopKeyboard.D);
  double timeReleased = gameLoop.keyboard.timeReleased(GameLoopKeyboard.D);
  
  if (gameLoop.keyboard.released(GameLoopKeyboard.D)) {
    print('D down: $down $timePressed $timeReleased');
    //gameLoop.enableFullscreen(true);
  }
}

void main() {
  gameLoop = new GameLoop(query('#gameElement'));
  gameLoop.onUpdate = update;
  gameLoop.start();
}