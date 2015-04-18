part of ld32;

class Sprite {
  ImageElement img;
  int width;
  int height;
  //int spritesPerImgWidth;
  //int spritesPerImgHeight;
  double alpha = 1.0;

  static CanvasRenderingContext2D context;
  
  Sprite(this.img, this.width, this.height) {
    //spritesPerImgWidth = img.width ~/ width;
    //spritesPerImgHeight = img.height ~/ height;
  }
  
  void setAlpha(double in_alpha) {
    alpha = in_alpha;
  }
  
  void draw(num x, num y, num width, num height) {
    context.globalAlpha = alpha;
    context.drawImageScaled(
        img,
        x,
        y, 
        width, 
        height);
    // TODO: Reset global alpha?
  }
}