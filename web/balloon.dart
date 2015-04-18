part of ld32;

class Vector2 {
  num x;
  num y;
  Vector2(this.x, this.y);
  
  operator +(Vector2 other) {
    return new Vector2(this.x + other.x, this.y + other.y);
  }
  
  operator *(double scalar) {
    return new Vector2(this.x * scalar, this.y * scalar);
  }
}

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