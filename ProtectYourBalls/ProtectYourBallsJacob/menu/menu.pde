void menu() {
  player.play();
  if (aud1%(29*frameRate)==0) {
    player.rewind();
    player.play();
  }
  aud1++;
  if (aud1==1740) {
    aud1=0;
  }

  background(30,144,255);
  button1();
  button2();
  button3();
}

void button1() {
  fill(255);
  //rect(width/2, height/4, width/4, height/10);
  image(button1,width/2,height/4,2*width/8,height/10);
}

void button2() {
  fill(255);
  //rect(width/2, 9*height/20, 2*width/8, height/10);
  image(button2,width/2,9*height/20,2*width/8,height/10);
}

void button3() {
  fill(255);
  //rect(width/2, 13*height/20, 2*width/8, height/10);
  image(button3,width/2,13*height/20,2*width/8,height/10);
}

