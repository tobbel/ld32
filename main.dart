library ld32;
import 'dart:html';
import 'dart:async';

part 'game.dart';

CanvasElement canvas;
Game game;
double lastFrameTime = 0.0;

void main() {
  init();
}

void init() {
  canvas = querySelector('#game');
  game = new Game(canvas);
  // TODO: OnResize, OnFullscreen; canvas width, height
  
  scheduleMicrotask(game.start);
  window.animationFrame.then(update);
}

void update(double frameTime) {
  double dt = (frameTime - lastFrameTime).toDouble() * 0.001;
  
  game.update(dt);
  
  lastFrameTime = frameTime;
  window.animationFrame.then(update);
}