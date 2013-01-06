library audio_manager;

import 'dart:html';
import 'dart:web_audio';
import 'audio.dart';

typedef AudioLoadDelegate(Audio audio);

class AudioManager {
  static Map<String, Audio> _audios = new Map<String, Audio>();
  static List<Audio> _audiosLoading = new List<Audio>();
  static Function onLoadComplete;
  
  static AudioContext audioContext;
  static GainNode gainNode;
  
  static void setup()
  {
    audioContext = new AudioContext();
    gainNode = audioContext.createGain();
  }
  
  static Audio get(String audioName)
  {
    return _audios[audioName];
  }
  
  static void load(String audioName, {AudioLoadDelegate callback: null})
  {
    HttpRequest xhr = new HttpRequest();
    
    Audio audio = new Audio(audioName, audioContext);
    xhr.open("GET", "audio\\$audioName", true);
    xhr.responseType = "arraybuffer";
    
    _audios[audioName] = audio;
    _audiosLoading.add(audio);
    
    xhr.on.load.add((event) {
      print('Loaded audio file $audioName');
      
      audioContext.decodeAudioData(xhr.response, (buffer) {
        audio.postLoad(buffer);
        
        if(callback != null)
          callback(audio);
        
        _audiosLoading.removeAt(_audiosLoading.indexOf(audio));
        if(_audiosLoading.length == 0 && onLoadComplete != null)
        {    
          onLoadComplete();
        }
      });
    });
    
    xhr.send();
    print('Started fetching audio file $audioName');
    
  }
}
