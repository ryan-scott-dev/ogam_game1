library loading_screen;

import 'dart:html';
import 'package:game_loop/game_loop.dart';
import 'package:vector_math/vector_math_browser.dart';
import 'package:js/js.dart' as js;

import 'game_screen.dart';
import 'screen_manager.dart';

class LoadingScreen extends GameScreen {
  static final BAR_WIDTH = 400;
  static final BAR_HEIGHT = 30;
  static final BAR_PADDING = 4;
  
  js.Proxy progressBar;
  
  LoadingScreen(ScreenManager screenManager) 
    : super(screenManager)
  {
    js.scoped(() {
      var kinetic = js.context.Kinetic;
      var progressBarBase = js.retain(new js.Proxy(kinetic.Rect, js.map({
        'fill': 'rgba(189,189,189,1)', 
        'x': this.width / 2.0 - BAR_WIDTH / 2.0, 'y': this.height / 2.0 - BAR_HEIGHT / 2.0, 
        'width': BAR_WIDTH, 'height': BAR_HEIGHT,
        'cornerRadius': 10,
        'shadow': 
          {
            'color': '#666',
            'blur': 5,
            'offset': [2, 2],
          },
      })));
      
      var progressBarBackground = js.retain(new js.Proxy(kinetic.Rect, js.map({
        'fill': {
          'start': {
            'x': 0,
            'y': 0
          },
          'end': {
            'x': 0,
            'y': BAR_HEIGHT
          },
          'colorStops': [0, 'rgba(255,255,255, 0.1)', 0.4, 'rgba(255,255,255, 0.7)', 1, 'rgba(255,255,255,0.4)'],
        }, 
        'x': this.width / 2.0 - BAR_WIDTH / 2.0, 'y': this.height / 2.0 - BAR_HEIGHT / 2.0, 
        'width': BAR_WIDTH, 'height': BAR_HEIGHT,
        'cornerRadius': 10,
      })));
      
      progressBar = js.retain(new js.Proxy(kinetic.Rect, js.map({
        'fill': {
          'start': {
            'x': 0,
            'y': 0
          },
          'end': {
            'x': 0,
            'y': BAR_HEIGHT
          },
          'colorStops': [0, '#9ED1FF', 0.4, '#ADD9FF', 1, '#4DA4F3'],
        },
        'x': progressBarBackground.getX() + BAR_PADDING, 'y': progressBarBackground.getY() + BAR_PADDING, 
        'width': BAR_WIDTH  - BAR_PADDING * 2, 'height': BAR_HEIGHT - BAR_PADDING * 2,
        'cornerRadius': 4,
        'scale':
          {
            'x': 0,
            'y': 1,
          }
      })));
      
      var loading = js.retain(new js.Proxy(kinetic.Text, js.map({
        'text': 'Loading...',
        'x': progressBarBackground.getX(), 'y': progressBarBackground.getY() - BAR_HEIGHT - BAR_PADDING,
        'fontSize': 24,
        'textFill': '#E7F2DF',
        'textShadow': {
          'color': '#555',
          'blur': 1,
          'offset': [1, 1],
          'opacity': 0.7},
      })));
      
      layer.add(progressBarBase);
      layer.add(progressBarBackground);
      layer.add(progressBar);
      layer.add(loading);
    });
  }
  
  void updateProgress(int current, int total)
  {
    var percentage = (current / total);
    
    js.scoped(() {
      progressBar.transitionTo(js.map({
        'scale': {
          'x': percentage,
          'y': 1
        },
        'duration': 0.1,
      }));
    });
    
    print("Loaded $percentage%");
  }
}
