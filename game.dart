part of ld32;

class Game {
  CanvasElement canvas;
  Game(this.canvas) {
    
  }
  
  void start() {
    print('start');
  }
  
  void update(double dt) {
    print('update, dt: ${dt}');
  }
}