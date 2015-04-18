part of ld32;

class Balloon {
  Sprite sprite;
  Vector2 position;
  Vector2 startPosition;
  double scale;
  Balloon(this.sprite, this.position, this.scale) {
    startPosition = position;
  }
  
  // TODO: Temp stuff
  Vector2 target;
  double moveTimer = 0.0;
}