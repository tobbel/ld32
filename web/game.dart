part of ld32;

// Things that need to be passed to UI
class GameData {
  double peopleSatisfaction = 1.0;
  double leaderSatisfaction = 1.0;
  double terrorLevel = 0.0;  
  // TODO: Date? Balloons?
}

class Game {
  static const int canvasWidth = 1280;
  static const int canvasHeight = 720;
  CanvasRenderingContext2D context;
  int year = 1941;
  int month = 12;
  static const int START_MONTHS_LEFT = 44;
  int monthsLeft = START_MONTHS_LEFT;
  int balloonsToLaunch = 0;
  int balloonsToCreate = 0;
  Sprite bgSprite;
  Sprite balloonSprite;
  
  Vector2 launchAreaPosition = new Vector2(150, 285);
  Vector2 launchAreaSize = new Vector2(24, 24);
  
  Vector2 targetAreaPosition = new Vector2(900, 250);
  Vector2 targetAreaSize = new Vector2(341, 175);
  
  GameData gameData;
  UI ui;
  List<Balloon> balloons = new List<Balloon>();
  Math.Random rand = new Math.Random();
  
  Game(this.context) {
    context.canvas.width = canvasWidth;
    context.canvas.height = canvasHeight;
    
    ImageElement img = new ImageElement(src: '../img/map.png', width: 1280, height: 800);//, context.canvas.width, context.canvas.height);
    bgSprite = new Sprite(img, img.width, img.height);
    ImageElement balloonImg = new ImageElement(src: '../img/balloon3.png', width: 64, height: 128);
    balloonSprite = new Sprite(balloonImg, img.width, img.height);
    
    Sprite.context = context;
    
    gameData = new GameData();
    ui = new UI(context.canvas, uiCallback, gameData);
    ui.setDate(year, month);
    ui.setNumBalloons(balloonsToCreate);
  }
  
  void start() {
    // Setup UI
    // Setup starting conditions
  }
  
  void update(double dt) {
    balloons.forEach((b) {
      b.moveTimer += dt;
      double fraction = b.moveTimer / 5.0;
      b.position = b.startPosition + (b.target - b.startPosition) * fraction;
      b.position.y -= 100.0 * (Math.sin(fraction * Math.PI) + Math.sin(fraction * 20.0) / 10.0);
      if (fraction >= 1.0) {
        b.scale = 10.0;
      }
    });
    
    // TODO: Update bound to framerate, might do for this
    draw(dt);
  }
  
  void uiCallback(String type) {
    
  }
  
  void keyPress(KeyboardEvent e) {
    print(e.keyCode.toString());
    if (e.keyCode == 113) {
      // Increase balloons
      balloonsToCreate++;
      ui.setNumBalloons(balloonsToCreate);
    }
    if (e.keyCode == 97) {
      // Decrease balloons
      balloonsToCreate--;
      ui.setNumBalloons(balloonsToCreate);
    }
    
    if (e.keyCode == 32) {
      // Try to pass month
      incrementDate();
    }
  }
  
  void draw(double dt) {
    context.clearRect(0, 0, context.canvas.width, context.canvas.height);
    
    // Fill BG
    context.fillStyle = "rgba(158, 198, 242, 1.0)";
    context.fillRect(0, 0, context.canvas.width, context.canvas.height);
    
    // Draw BG sprites
    // TODO: Temp
    context.fillStyle = "green";
    context.fillRect(launchAreaPosition.x, launchAreaPosition.y, launchAreaSize.x, launchAreaSize.y);
    context.fillStyle = "red";
    context.fillRect(targetAreaPosition.x, targetAreaPosition.y, targetAreaSize.x, targetAreaSize.y);
    //bgSprite.draw(0, 0, context.canvas.width, context.canvas.height);
    
    // Draw balloons
    balloons.forEach((b) {
      balloonSprite.draw(b.position.x, b.position.y, 64 * b.scale, 128 * b.scale);
    });
    
    // TODO: Do this in update
    double previewSatisfaction = 1.0;//gameData.peopleSatisfaction - 0.012 * (numBalloons + monthsLeft);

    // Draw UI
    ui.draw(dt, previewSatisfaction);
  }
  
  void changeNumBalloons(int number) {
//    numBalloons += number;
//    ui.setNumBalloons(numBalloons);
  }
  
  void incrementDate() {
    // Launch any available balloons
    if (balloonsToLaunch > 0) {
      // TODO: Cleared on landing?
      balloons.clear();
      for (int i = 0; i < balloonsToLaunch; i++) {
        // Start positions
        Vector2 startPosition = launchAreaPosition + new Vector2(rand.nextInt(launchAreaSize.x), rand.nextInt(launchAreaSize.y));
        Vector2 targetPosition = targetAreaPosition + new Vector2(rand.nextInt(targetAreaSize.x), rand.nextInt(targetAreaSize.y));
        // TODO: Rand scale, rand wait time before launch (1 sec max) 
        balloons.add(new Balloon(startPosition, targetPosition, 1.0));     
      }
      balloonsToLaunch = 0;
    }
    
    if (balloonsToCreate > 0) {
      // Create balloons
      balloonsToLaunch = balloonsToCreate;
    }
    
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
    
    // TODO: Tweak, less months left increases satisfaction drop
//    gameData.peopleSatisfaction -= 0.0012 * (numBalloons + monthsLeft);
    print('peopleSatisfaction: ${gameData.peopleSatisfaction}');
    // TODO: Leader satisfaction drops to 0 after half the time of drops with no bombs 
    gameData.leaderSatisfaction -= 1.0 / (START_MONTHS_LEFT / 2.0);
    print('leaderSatisfaction: ${gameData.leaderSatisfaction}');

    // TODO: Some sort of log
  }
  
//  bool isDown = false;
//  void mouseDown(Vector2 position) {
//    if (!isDown)
//    {
//      isDown = true;  
//      ui.mouseDown(position);
//    }
//  }
//  
//  void mouseUp(Vector2 position) {
//    isDown = false;
//  }
}
