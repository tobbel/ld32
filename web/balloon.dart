part of ld32;

class Balloon {
  Vector2 startPosition;
  Vector2 position;
  Vector2 target;
  double scale;
  Balloon(this.position, this.target, this.scale) {
    startPosition = new Vector2(position.x, position.y);
  }
  
  // TODO: Global movetimer? Local random offset?
  double moveTimer = 0.0;
}