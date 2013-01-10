library audio;

import 'dart:html';
import 'dart:web_audio';

typedef AudioLoadDelegate(Audio audio);

class Audio {
  final String name;
  final List<AudioLoadDelegate> onLoadCallbacks = new List<AudioLoadDelegate>();
  
  bool loaded = false; 
  bool _failed = false;
  
  AudioBuffer _buffer;
  AudioContext _audioContext;
  
  Audio(this.name, this._audioContext)
  {
  }
  
  void runLoadCallbacks()
  {
    loaded = true;
    
    for(var callback in onLoadCallbacks)
    {
      callback(this);
    }
    
    onLoadCallbacks.clear();
  }
  
  void play({num when : 0})
  {
    if(loaded && !this._failed)
    {
      print('playing');
      
      var source = _audioContext.createBufferSource();
      source.buffer = _buffer;
      source.connect(_audioContext.destination, 0, 0);
      source.start(when);
    }
  }
  
  void setDecodedBuffer(AudioBuffer buffer)
  {
    this._buffer = buffer;
  }
  
  void onLoadFailure()
  {
    this._failed = true;
  }
  
  void onLoad(AudioLoadDelegate callback)
  {
    if(loaded)
    {
      callback(this);
      return;
    }
    
    onLoadCallbacks.add(callback);
  }
}
