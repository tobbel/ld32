part of ld32;

class UI {
  CanvasElement canvas;
  Function incrementDateFunction;
  Function numBalloonsChangedFunction;
  LabelElement dateLabel;
  LabelElement numBalloonsLabel;
  UI(this.canvas, this.incrementDateFunction, this.numBalloonsChangedFunction) {
    DivElement div = new DivElement();
    
    // Test buttons
    ButtonElement leftButton = new ButtonElement();
    leftButton.text = '<';
    leftButton.onClick.listen(leftClick);
    div.append(leftButton);
    numBalloonsLabel = new LabelElement();
    div.append(numBalloonsLabel);
    ButtonElement rightButton = new ButtonElement();
    rightButton.text = '>';
    rightButton.onClick.listen(rightClick);
    div.append(rightButton);
    
    div.append(new ParagraphElement());
    // Cycle date
    var dateButton = new ButtonElement();
    dateButton.text = 'Pass time 1 month';
    dateButton.onClick.listen(onDateButtonClicked);
    div.append(dateButton);
    
    dateLabel = new LabelElement();
    div.append(dateLabel);
    
    canvas.parent.append(div);
  }
  
  void onDateButtonClicked(MouseEvent e) {
    incrementDateFunction();
  }
  
  void leftClick(MouseEvent e) {
    numBalloonsChangedFunction(-1);
  }
  
  void rightClick(MouseEvent e) {
    numBalloonsChangedFunction(1);
  }
  
  void setNumBalloons(int numBalloons) {
    numBalloonsLabel.text = numBalloons.toString();
  }
  
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
    dateLabel.text = monthString + ' ' + year.toString();
  }
}
