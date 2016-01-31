class BadBalls extends Ball {
  float xVel, yVel;
  BadBalls(float x, float y, float sze, float txVel, float tyVel) {
    super(x, y, sze);
    xVel=txVel;
    yVel=tyVel;
  }
  void update() {
    x+=xVel;
    y+=yVel;
  }
}

