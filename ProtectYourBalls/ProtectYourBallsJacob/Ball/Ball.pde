class Ball {
  float x, y, sze;
  Ball(float tempX, float tempY, float tempSize) {
    x=tempX;
    y=tempY;
    sze=tempSize;
  }
  void display() {
    image(ball,x,y,sze,sze);
    ellipse(x, y, sze, sze);
  }
  void reset(float tX, float tY, float tSize) {
    x=tX;
    y=tY;
    sze=tSize;
  }
  void setXY(float xChange, float yChange) {
    x+=xChange;
    y+=yChange;
  }
  float getX() {
    return x;
  }
  float getY() {
    return y;
  }
  float getDiam() {
    return sze;
  }
}

