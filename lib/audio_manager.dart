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
  static bool enabled = true;
  
  static void setup()
  {
    try
    {
      audioContext = new AudioContext();
      gainNode = audioContext.createGain();
    }
    catch (e)
    {
      enabled = false;
      print("Web Audio is not enabled for this browser");
    }
    
    if(audioContext == null)
    {
      enabled = false;
      print("Web Audio is not enabled for this browser");
    }
  }
  
  static Audio get(String audioName)
  {
    return _audios[audioName];
  }
  
  static void load(String audioName, {AudioLoadDelegate callback: null})
  {
    Audio audio = new Audio(audioName, audioContext);

    _audios[audioName] = audio;
    _audiosLoading.add(audio);
    
    if(enabled)
    {
      HttpRequest xhr = new HttpRequest();
      
      xhr.open("GET", "audio\\$audioName", true);
      xhr.responseType = "arraybuffer";
      
      xhr.on.load.add((event) {
        try
        {
          print('Loaded audio file $audioName');
        
          audioContext.decodeAudioData(xhr.response, (buffer) {
            audio.load(buffer);
            
            if(callback != null)
              callback(audio);
          
            _audiosLoading.removeAt(_audiosLoading.indexOf(audio));
            if(_audiosLoading.length == 0 && onLoadComplete != null)
            {    
              onLoadComplete();
            }
          },
          (buffer) {
            audio.onLoadFailure();
            
            if(callback != null)
              callback(audio);
          });
        }
        catch (e) {
          audio.onLoadFailure();
          
          if(callback != null)
            callback(audio);
        }
      });
      
      xhr.send();
      print('Started fetching audio file $audioName');
    }
    else
    {
      audio.onLoadFailure();
      
      if(callback != null)
        callback(audio);
    }
  }
}
