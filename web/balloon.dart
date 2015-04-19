part of ld32;

class Balloon {
  Vector2 startPosition;
  Vector2 position;
  Vector2 target;
  double scale;
  double moveTime;
  double moveTimer = 0.0;
  double startTimer;
  Balloon(this.position, this.target, this.moveTime, this.startTimer, this.scale) {
    startPosition = new Vector2(position.x, position.y);
    moveTimer = moveTime;
  }
}