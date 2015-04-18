part of ld32;

class Vector2 {
  num x;
  num y;
  Vector2(this.x, this.y);
  
  operator +(Vector2 other) {
    return new Vector2(this.x + other.x, this.y + other.y);
  }
  
  operator -(Vector2 other) {
    return new Vector2(this.x - other.x, this.y - other.y);
  }
  
  operator *(double scalar) {
    return new Vector2(this.x * scalar, this.y * scalar);
  }
  
  String toString() => '${x}, ${y}';
}