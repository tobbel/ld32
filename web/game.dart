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
  Sprite bgSprite;
  Sprite balloonSprite;
  List<Balloon> balloons = new List<Balloon>();
  var viewScale = new Vector2(1, 1);
  Game(this.context) {
    context.canvas.onDoubleClick.listen((onData) {
      document.onFullscreenChange.listen((onData) {
        if (context.canvas == document.fullscreenElement) {
          context.canvas.width = window.innerWidth;
          context.canvas.height = window.innerHeight;
          viewScale = new Vector2(context.canvas.width / 600, context.canvas.height / 327);
        } else {
          context.canvas.width = 600;
          context.canvas.height = 375;
        }
      });
      
      if (context.canvas == document.fullscreenElement) {
        document.exitFullscreen();
      } else {    
        fullscreenWorkaround(context.canvas);
      }
    });
    
    ImageElement img = new ImageElement(src: '../img/map.png', width: 1280, height: 800);//, context.canvas.width, context.canvas.height);
    bgSprite = new Sprite(img, img.width, img.height);
    ImageElement balloonImg = new ImageElement(src: '../img/balloon.png', width: 256, height: 768);
    balloonSprite = new Sprite(balloonImg, img.width, img.height);
    
    Sprite.context = context;
    ui = new UI(context.canvas, incrementDate, changeNumBalloons);
    // TODO: UI.SetListenerThis(this); UI.SetListenerThat(that), etc.
    ui.setDate(year, month);
    ui.setNumBalloons(numBalloons);
  }
  
  void start() {
    print('start');
  }
  
  void update(double dt) {
    balloons.forEach((b) {
      b.moveTimer += dt;
      // TODO: Move over, let's say, 10 seconds
      double fraction = b.moveTimer / 10.0;
      b.position = b.startPosition + b.target * fraction;
    });
    
    // TODO: Update bound to framerate, might do for this
    draw(dt);
  }
  
  void draw(double dt) {
    context.clearRect(0, 0, context.canvas.width, context.canvas.height);
    bgSprite.draw(0, 0, context.canvas.width, context.canvas.height);
    balloons.forEach((b) {
      b.sprite.draw(b.position.x, b.position.y, 16 * b.scale, 48 * b.scale);
      //balloonSprite.draw(100, 100, 16, 48);
    });
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
    // TODO: Temp rand
    Math.Random rand = new Math.Random();
    balloons.clear();
    var startPosition = new Vector2(50, 50);
    for (int i = 0; i < numBalloons; i++) {
      Vector2 position = startPosition + new Vector2(rand.nextInt(10) - 5, rand.nextInt(10) - 5);
      balloons.add(new Balloon(balloonSprite, position, rand.nextDouble() * 0.8));
      // TODO: Temp
      balloons[i].target = new Vector2(500, 100);
    }
    
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
