library audio;

import 'dart:html';
import 'dart:web_audio';

typedef AudioLoadDelegate(Audio audio);

class Audio {
  final String name;
  final List<AudioLoadDelegate> onLoadCallbacks = new List<AudioLoadDelegate>();
  
  bool loaded = false; 
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
    print('playing');
    var source = _audioContext.createBufferSource();
    source.buffer = _buffer;
    source.connect(_audioContext.destination, 0, 0);
    source.start(when);
  }
  
  void setDecodedBuffer(AudioBuffer buffer)
  {
    this._buffer = buffer;
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
