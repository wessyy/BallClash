void play() {
  if (mode==1 && frameCount==1) {
    sze=width/20;
    speed=1.5;
    time=30;
    yours1.reset(width/2-width/10, height/2, sze);
    yours2.reset(width/2+width/10, height/2, sze);
  }
  if (mode==2 && frameCount==1) {
    sze=width/15;
    speed=2;
    time=45;
    yours1.reset(width/2-width/10, height/2, sze);
    yours2.reset(width/2+width/10, height/2, sze);
  }
  if (mode==3 && frameCount==1) {
    sze=width/10;
    speed=2.5;
    time=60;
    yours1.reset(width/2-width/10, height/2, sze);
    yours2.reset(width/2+width/10, height/2, sze);
  }

  if (frameCount>time*rate) { //Win Condition
    player2.pause();
    player3.play();
    aud2=0;
    frame="win";
  }

  background(30,144,255);
  noFill();
  rect(width/2, height/2, width-2*sze, height-2*sze);

  //YourBalls
  fill(0, 255, 0, 100); //Good color
  yours1.display();
  yours2.display();
  fill(255, 0, 0, 100); //Bad color
  if (holding==1) {
    if (dist(yours1.getX()+(mouseX-pmouseX), yours1.getY()+(mouseY-pmouseY), yours2.getX(), yours2.getY())>sze) {
      if (mouseX>sze && mouseX<width-sze && mouseY>sze && mouseY<height-sze) {
        yours1.setXY(mouseX-pmouseX, mouseY-pmouseY);
      } else {
        holding=0;
      }
    } else {
      holding=0;
    }
  }
  if (holding==2) {
    if (dist(yours2.getX()+(mouseX-pmouseX), yours2.getY()+(mouseY-pmouseY), yours1.getX(), yours1.getY())>sze) {
      if (mouseX>sze && mouseX<width-sze && mouseY>sze && mouseY<height-sze) {
        yours2.setXY(mouseX-pmouseX, mouseY-pmouseY);
      } else {
        holding=0;
      }
    } else {
      holding=0;
    }
  }
  //-----

  //BadBalls
  if ((frameCount*speed)%90==0) {
    addBall(int(random(2)), int(random(2)));
  }
  for (int i=balls.size ()-1;i>=0; i--) {
    BadBalls bball = balls.get(i);
    bball.update();
    bball.display();
    checkHit(bball.getX(), bball.getY(), bball.getDiam());
    if (bball.getX()<0 || bball.getX()>width || bball.getY()<0 || bball.getY()>height) {
      balls.remove(i);
    }
  }
  //-----
  
  //Timer
  fill(255, 255, 0);
  text("Time left: "+(time-int(frameCount/rate)), width/2, width/23);
  //-----
  //System.out.println(frameRate+" - "+rate);
}

void mousePressed() {
  if (frame=="play") {
    if (holding==0) {
      if (dist(yours1.getX(), yours1.getY(), mouseX, mouseY)<sze/2) {
        holding=1;
      } else 
        if (dist(yours2.getX(), yours2.getY(), mouseX, mouseY)<sze/2) {
        holding=2;
      }
    }
  }
}

void addBall(int r1, int r2) {
  if (r1==0) {
    if (r2==0) {
      balls.add(new BadBalls(0, random(height), random(width/20, width/(25-5*mode)), random(width/600, width*speed/600), 0));
    } else {
      balls.add(new BadBalls(width, random(height), random(width/20, width/(25-5*mode)), -1*(random(width/600, width*speed/600)), 0));
    }
  } else {
    if (r2==0) {
      balls.add(new BadBalls(random(width), 0, random(width/20, width/(25-5*mode)), 0, random(width/600, width*speed/600)));
    } else {
      balls.add(new BadBalls(random(width), height, random(width/20, width/(25-5*mode)), 0, -1*(random(width/600, width*speed/600))));
    }
  }
}

void checkHit(float hitterX, float hitterY, float hitterD) {
  if (dist(hitterX, hitterY, yours1.getX(), yours1.getY())<((hitterD/2)+(sze/2))||dist(hitterX, hitterY, yours2.getX(), yours2.getY())<((hitterD/2)+(sze/2))) {
    player2.pause();
    player4.play();
    aud3=0;
    frame="lose";
  }
}

