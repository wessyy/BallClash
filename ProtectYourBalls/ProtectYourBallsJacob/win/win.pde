void win() {
  if (aud2%(30*frameRate)==0) {
    player3.rewind();
    player3.play();
  }
  aud2++;

  background(0, 255, 0);
  button4();
}

void button4() {
  fill(255);
  rect(width/2, height/2, 2*width/8, height/8);
  fill(0);
  text("Play again?",width/2,height/2);
  //image(button4,width/2,height/2,2*width/8,height/8);
}

void playAgain() {
  for (int i=balls.size ()-1; i>=0; i--) {
    balls.remove(i);
  }
  player3.pause();
  player4.pause();
  aud1=0;
  frame="menu";
}

