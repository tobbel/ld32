part of ld32;

class Button {
  Vector2 position;
  Vector2 size;
  String text;
  Function onClick;
  Button(this.position, this.size, this.text, this.onClick);
}

class UI {
  CanvasElement canvas;
  GameData gameData;
  LabelElement dateLabel;
  LabelElement numBalloonsLabel;
  UI(this.canvas, this.gameData);
  
  void draw(double dt, double satisfaction) {
    var context = canvas.context2D;
    context.fillStyle = 'blue';
    context.rect(0, 0, 10, 100);
    context.stroke();
    
    context.globalAlpha = 0.5;
    context.fillRect(0, 25, 9, 75);
    context.globalAlpha = 1.0;
    var height = 100 * satisfaction;
    context.fillRect(0, 100 - height, 9, height);
    
    context.fillStyle = "black";
    context.font = "24px Roboto";
    var dateMetrics = context.measureText(dateString);
    var offset = 10;
    context.fillText(dateString, context.canvas.width / 2 - dateMetrics.width / 2, dateMetrics.fontBoundingBoxAscent + offset);

    // UI on lower 1/3 of screen
    // TODO: Super temp
    var x = 0;
    var y = canvas.height * 2/3;
    var w = canvas.width;
    var h = canvas.height / 3;
    context.fillStyle = "rgba(100, 75, 0, 1)";
    context.fillRect(x, y, w, h);
    context.fillStyle = "rgba(255, 255, 208, 1)";
    context.fillRect(x + 5, y + 5, w - 10, h - 10);
    
    var margin = 5;
    var spanH = h - margin * 2;
    var spanW = w - margin * 2;
    var startX = x + margin;
    var startY = y + margin;
    
    var boxWidth = spanW / 2;
    startX += margin;
    boxWidth -= margin * 2;
    startY += margin;
    var boxHeight = (spanH / 3) - (margin / 3);
    boxHeight -= margin;
    context.fillStyle = "black";
    //context.fillRect(startX, startY, boxWidth, boxHeight / 2 - margin / 2);

    context.font = "12px Roboto";
    var balloonText = 'Balloons to create this month: ' + gameData.balloonsToCreate.toString();
    var metrics = context.measureText(balloonText);
    
    context.fillText(balloonText, startX, startY + metrics.fontBoundingBoxAscent);
    
    balloonText = 'Balloons ready to launch: ' + gameData.balloonsToLaunch.toString();
    metrics = context.measureText(balloonText);
    context.fillText(balloonText, startX, startY + metrics.fontBoundingBoxAscent * 2 + 5);
    
    
    context.fillRect(startX, startY + boxHeight + margin, boxWidth, boxHeight);
    context.fillRect(startX, startY + boxHeight*2 + margin*2, boxWidth, boxHeight);
    
    startX += boxWidth + margin * 2;
    context.fillRect(startX, startY, boxWidth, boxHeight);
    context.fillRect(startX, startY + boxHeight + margin, boxWidth, boxHeight);
    context.fillRect(startX, startY + boxHeight*2 + margin*2, boxWidth, boxHeight);

    context.fillStyle = "rgba(100, 75, 0, 1)";
    context.fillRect(x + boxWidth + margin * 2 + 3, y, margin - 1, h);
  }
   
  String dateString = '';
  void setDate(int year, int month) {
    var monthString = '';
    switch (month) {
      case 1:
        monthString = 'January';
        break;
      case 2:
        monthString = 'February';
        break;
      case 3:
        monthString = 'March';
        break;
      case 4:
        monthString = 'April';
        break;
      case 5:
        monthString = 'May';
        break;
      case 6:
        monthString = 'June';
        break;
      case 7:
        monthString = 'July';
        break;
      case 8:
        monthString = 'August';
        break;
      case 9:
        monthString = 'September';
        break;
      case 10:
        monthString = 'October';
        break;
      case 11:
        monthString = 'November';
        break;
      case 12:
        monthString = 'December';
        break;
      default:
        monthString = '---';
        break;
    }
    dateString = monthString + ' ' + year.toString();
  }
}
