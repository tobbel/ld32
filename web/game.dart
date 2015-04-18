part of ld32;

class Game {
  CanvasElement canvas;
  UI ui;
  int year = 1941;
  int month = 12;
  int numBalloons = 10;
  Game(this.canvas) {
    ui = new UI(canvas, incrementDate, changeNumBalloons);
    ui.setDate(year, month);
    ui.setNumBalloons(numBalloons);
  }
  
  void start() {
    print('start');
  }
  
  void update(double dt) {
    
  }
  
  void changeNumBalloons(int number) {
    numBalloons += number;
    ui.setNumBalloons(numBalloons);
  }
  
  void incrementDate() {
    // Pass time
    month = (month + 1) % 13;
    if (month == 0) {
      month++;
      year++;
    }
    
    ui.setDate(year, month);
    
    if (month == 8 && year == 1945) {
      print('you lose');
    }
    
    // Move balloons
    // Create balloons
  }
}
