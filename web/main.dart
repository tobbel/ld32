library ld32;

import 'dart:html';
import 'dart:async';
import 'dart:js';
import 'dart:math' as Math;

part 'game.dart';
part 'ui.dart';
part 'sprite.dart';
part 'balloon.dart';
part 'vector2.dart';

CanvasElement canvas;
Game game;
double lastFrameTime = 0.0;

void main() {
  init();
}

void init() {
  canvas = querySelector('#game');
  canvas.width = 600;
  canvas.height = 375;
  game = new Game(canvas.context2D);
  
  window.onKeyPress.listen(keyPress);
  
  scheduleMicrotask(game.start);
  window.animationFrame.then(update);
}

void update(double frameTime) {
  double dt = (frameTime - lastFrameTime).toDouble() * 0.001;
  
  game.update(dt);
  
  lastFrameTime = frameTime;
  window.animationFrame.then(update);
}

void keyPress(KeyboardEvent e) {
  game.keyPress(e);
}
