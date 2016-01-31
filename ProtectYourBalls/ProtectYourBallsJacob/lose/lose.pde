void lose() {
  if (aud3%(43*frameRate)==0) {
    player4.rewind();
    player4.play();
  }
  aud3++;

  background(255, 0, 0);
  button4();
}

