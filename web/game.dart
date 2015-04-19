part of ld32;

// Things that need to be passed to UI
class GameData {
  double peopleSatisfaction = 1.0;
  double peopleSatisfactionChange = 0.0;
  double leaderSatisfaction = 1.0;
  double leaderSatisfactionChange = 0.0;
  double terrorLevel = 0.0;
  int balloonsToLaunch = 0;
  int balloonsToCreate = 0;
}

enum GameState {
  //MENU
  WAIT,
  FLYING
  //, LOG
}
class Game {
  GameState currentState = GameState.WAIT;
  static const int canvasWidth = 1280;
  static const int canvasHeight = 720;
  CanvasRenderingContext2D context;
  int year = 1941;
  int month = 12;
  static const int START_MONTHS_LEFT = 44;
  int monthsLeft = START_MONTHS_LEFT;
  //Sprite bgSprite;
  Sprite balloonSprite;
  Sprite failSprite;
  Sprite explosionSprite;
  
  Vector2 launchAreaPosition = new Vector2(150, 285);
  Vector2 launchAreaSize = new Vector2(24, 24);
  
  Vector2 targetAreaPosition = new Vector2(900, 250);
  Vector2 targetAreaSize = new Vector2(341, 175);
  
  GameData gameData;
  UI ui;
  List<Balloon> balloons = new List<Balloon>();
  List<Vector2> failedBalloons = new List<Vector2>();
  List<Vector2> explodedBalloons = new List<Vector2>();
  Math.Random rand = new Math.Random();
  
  Game(this.context) {
    context.canvas.width = canvasWidth;
    context.canvas.height = canvasHeight;
    
    //var mapImage = new ImageElement(src: '../img/map.png', width: 1280, height: 800);
    //bgSprite = new Sprite(mapImage, mapImage.width, mapImage.height);
    var balloonImage = new ImageElement(src: '../img/balloon3.png', width: 64, height: 128);
    balloonSprite = new Sprite(balloonImage, balloonImage.width, balloonImage.height);
    var failImage = new ImageElement(src: '../img/fail.png', width: 64, height: 64);
    failSprite = new Sprite(failImage, failImage.width, failImage.height);
    var explosionImage = new ImageElement(src: '../img/explosion.png', width: 64, height: 64);
    explosionSprite = new Sprite(explosionImage, explosionImage.width, explosionImage.height);
    
    Sprite.context = context;
    
    gameData = new GameData();
    ui = new UI(context.canvas, gameData);
    ui.setDate(year, month);
  }
  
  void start() {
    // Setup UI
    // Setup starting conditions
  }
  
  void update(double dt) {
    for (Balloon b in balloons) {
      // Wait to start with some balloons
      if (b.startTimer > 0) {
        b.startTimer -= dt;
        continue;        
      }
      
      // Movement
      if (b.moveTimer >= 0.0) {
        b.moveTimer -= dt;
        double fraction = 1 - (b.moveTimer / b.moveTime);
        b.position = b.startPosition + (b.target - b.startPosition) * fraction;
        b.position.y -= 100.0 * (Math.sin(fraction * Math.PI) + Math.sin(fraction * 20.0) / 10.0);
        
        if (b.moveTimer <= 0.0) {
          b.moveTimer = 0.0;
          explodedBalloons.add(b.position);
          // TODO: Satisfaction based on kills
          gameData.peopleSatisfaction += 0.01;
          gameData.leaderSatisfaction += 0.01;
        }
      }
      
      // Fail/bomb, etc.
      // Fail - calculate for this frame based on percentage over flight time
      double frameFailPercentage = b.failPercentage * dt / b.moveTime;
      if (frameFailPercentage > rand.nextDouble()) {
        b.moveTimer = 0.0;
        failedBalloons.add(b.position);
      }
    }
    
    balloons.removeWhere((b) => b.moveTimer <= 0);
    
    if (currentState == GameState.FLYING) {
      if (balloons.length == 0) {
        // Calculate terror level - increases more towards end
        gameData.terrorLevel += explodedBalloons.length * 0.01;
        gameData.terrorLevel *= 0.8;
        // TODO: Log state
        
        //gameData.peopleSatisfaction += gameData.peopleSatisfactionChange;
        //gameData.leaderSatisfaction += gameData.leaderSatisfactionChange;
        currentState = GameState.WAIT;
      }
    }
    
    // Calculate preview changes to people & leader satisfaction
    // People satisfaction: lower the more balloons you create, more closer to the end.
    gameData.peopleSatisfactionChange = -0.001 * (gameData.balloonsToCreate + (monthsLeft / START_MONTHS_LEFT) * 10.0);
    // Leader satisfaction: lower with time, lowers more closer to the end
    gameData.leaderSatisfactionChange = -1.0 / (START_MONTHS_LEFT / 2.0);

    //gameData.peopleSatisfaction -= 0.0012 * (numBalloons + monthsLeft);
    // TODO: Leader satisfaction drops to 0 after half the time of drops with no bombs 
    //gameData.leaderSatisfaction -= 1.0 / (START_MONTHS_LEFT / 2.0);

    draw(dt);
    
    var text = 'Current state: ' + currentState.toString();
    context.fillStyle = "black";
    context.font = "24px Roboto";
    var dateMetrics = context.measureText(text);
    var offset = 40;
    var size = 24;
    context.fillText(text, context.canvas.width / 2 - dateMetrics.width / 2, size + offset);
    text = 'People satisfaction: ' + gameData.peopleSatisfaction.toString();
    context.fillText(text, context.canvas.width / 2 - dateMetrics.width / 2, size + offset * 2);
    text = 'Leader satisfaction: ' + gameData.leaderSatisfaction.toString();
    context.fillText(text, context.canvas.width / 2 - dateMetrics.width / 2, size + offset * 3);
    text = 'Terror level: ' + gameData.terrorLevel.toString();
    context.fillText(text, context.canvas.width / 2 - dateMetrics.width / 2, size + offset * 4);
  }
  
  void keyPress(KeyboardEvent e) {
    if (e.keyCode == 113) {
      // Increase balloons
      gameData.balloonsToCreate++;
    }
    if (e.keyCode == 97) {
      // Decrease balloons
      gameData.balloonsToCreate--;
    }
    
    if (e.keyCode == 32) {
      // Try to pass month
      if (currentState == GameState.WAIT) {        
        incrementDate();
      }
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

    // Failed balloons
    for (Vector2 pos in failedBalloons) {
      failSprite.draw(pos.x, pos.y, 16, 16);
    }
    
    // Exploded balloons
    for (Vector2 pos in explodedBalloons) {
      explosionSprite.draw(pos.x, pos.y, 16, 16);
    }
    
    // Draw balloons
    balloons.forEach((b) {
      if (b.startTimer <= 0) {      
        balloonSprite.draw(b.position.x, b.position.y, 32 * b.scale, 64 * b.scale);
      }
    });

    // Draw UI
    ui.draw(dt);
  }
  
  void incrementDate() {
    // Remove old stuff
    balloons.clear();
    failedBalloons.clear();
    explodedBalloons.clear();
    
    // Launch any available balloons
    if (gameData.balloonsToLaunch > 0) {
      for (int i = 0; i < gameData.balloonsToLaunch; i++) {
        // Start positions
        Vector2 startPosition = launchAreaPosition + new Vector2(rand.nextInt(launchAreaSize.x), rand.nextInt(launchAreaSize.y));
        // TODO: Bigger target area - landing outside fails
        Vector2 targetPosition = targetAreaPosition + new Vector2(rand.nextInt(targetAreaSize.x), rand.nextInt(targetAreaSize.y));
        
        double startOffsetTime = rand.nextDouble() * 0.6;
        double moveTime = 5.0 + rand.nextDouble() * 3.0;
        
        // At start, 90% fail. At end, 10%.
        double failPercentage = 0.1 + 0.8 * (monthsLeft / START_MONTHS_LEFT);
        balloons.add(new Balloon(startPosition, targetPosition, moveTime, startOffsetTime, failPercentage, 1.0));     
      }
      gameData.balloonsToLaunch = 0;
    }
    
    if (gameData.balloonsToCreate > 0) {
      // Create balloons
      gameData.balloonsToLaunch = gameData.balloonsToCreate;
      gameData.peopleSatisfaction += gameData.peopleSatisfactionChange;
      gameData.peopleSatisfactionChange = 0.0;
    }
    
    // Pass time
    month = (month + 1) % 13;
    if (month == 0) {
      month++;
      year++;
    }
    
    ui.setDate(year, month);
    monthsLeft--;
    
    gameData.leaderSatisfaction += gameData.leaderSatisfactionChange;
    if (monthsLeft == 0) {
      print('you lose, months over');
    }
//    
//    // TODO: Tweak, less months left increases satisfaction drop
////    gameData.peopleSatisfaction -= 0.0012 * (numBalloons + monthsLeft);
//    print('peopleSatisfaction: ${gameData.peopleSatisfaction}');
//    // TODO: Leader satisfaction drops to 0 after half the time of drops with no bombs 
//    gameData.leaderSatisfaction -= 1.0 / (START_MONTHS_LEFT / 2.0);
//    print('leaderSatisfaction: ${gameData.leaderSatisfaction}');

    // TODO: Some sort of log
    currentState = GameState.FLYING;
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
