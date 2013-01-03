library player;

class Player {
  
  static Map<num, Player> players = new Map<int, Player>();
  
  static const num NEUTRAL = 0;
  static const num PLAYER = 1;
  static const num ENEMY = 2;
  
  num playerId;
  
  bool get isNeutral => playerId == Player.NEUTRAL;
  
  Player(this.playerId) {
    players[this.playerId] = this;
  }
  
  String getPlayerImage()
  {
    switch(playerId)
    {
      case NEUTRAL:
        return 'node_neutral.png';
      case PLAYER:
        return 'node_player.png';
      case ENEMY:
        return 'node_enemy.png';
    }
  }
  
  static void setup()
  {
    new Player(Player.NEUTRAL);
    new Player(Player.PLAYER);
    new Player(Player.ENEMY);
  }
  
  static Player get(num playerId)
  {
    return players[playerId];
  }
}
