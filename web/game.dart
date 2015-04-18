part of ld32;

class GameData {
  double peopleSatisfaction = 1.0;
  double leaderSatisfaction = 1.0;
  // TODO: Date?
}

class Game {
  CanvasRenderingContext2D context;
  UI ui;
  int year = 1941;
  int month = 12;
  static const int START_MONTHS_LEFT = 44;
  int monthsLeft = START_MONTHS_LEFT;
  int numBalloons = 0;
  GameData gameData = new GameData();
  Game(this.context) {
    context.canvas.onDoubleClick.listen((onData) {
      document.onFullscreenChange.listen((onData) {
        if (context.canvas == document.fullscreenElement) {
          context.canvas.width = window.innerWidth;
          context.canvas.height = window.innerHeight;
        } else {
          context.canvas.width = 600;
          context.canvas.height = 375;
        }
      });
      fullscreenWorkaround(context.canvas);
    });
    
    ui = new UI(context.canvas, incrementDate, changeNumBalloons);
    ui.setDate(year, month);
    ui.setNumBalloons(numBalloons);
  }
  
  void start() {
    print('start');
  }
  
  void update(double dt) {
    
    
    // TODO: Update bound to framerate
    draw(dt);
  }
  
  void draw(double dt) {
    context.clearRect(0, 0, context.canvas.width, context.canvas.height);
    double previewSatisfaction = gameData.peopleSatisfaction - 0.012 * (numBalloons + monthsLeft);
    ui.draw(dt, previewSatisfaction);
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
    monthsLeft--;
    if (monthsLeft == 0) {
      print('you lose, months over');
    }
    
    if (month == 8 && year == 1945) {
      print('you lose, monthsLeft: ${monthsLeft}');
    }
    
    // Create balloons
    // TODO: Tweak, less months left increases satisfaction drop
    gameData.peopleSatisfaction -= 0.0012 * (numBalloons + monthsLeft);
    print('peopleSatisfaction: ${gameData.peopleSatisfaction}');
    // TODO: Leader satisfaction drops to 0 after half the time of drops with no 
    gameData.leaderSatisfaction -= 1.0 / (START_MONTHS_LEFT / 2.0);
    print('leaderSatisfaction: ${gameData.leaderSatisfaction}');
    // Move balloons
    
  }
  
  void fullscreenWorkaround(Element element) {
    var elem = new JsObject.fromBrowserObject(element);

    if (elem.hasProperty("requestFullscreen")) {
      elem.callMethod("requestFullscreen");
    }
    else {
      List<String> vendors = ['moz', 'webkit', 'ms', 'o'];
      for (String vendor in vendors) {
        String vendorFullscreen = "${vendor}RequestFullscreen";
        if (vendor == 'moz') {
          vendorFullscreen = "${vendor}RequestFullScreen";
        }
        if (elem.hasProperty(vendorFullscreen)) {
          elem.callMethod(vendorFullscreen);
          return;
        }
      }
    }
  }
}
