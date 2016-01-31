//Audio
import ddf.minim.*;
Minim minim;
AudioPlayer player;
AudioPlayer player2;
AudioPlayer player3;
AudioPlayer player4;
float aud1, aud2, aud3;
//-----

//Images
PImage dirs;
PImage ball;
PImage button1;
PImage button2;
PImage button3;
PImage button4;
//-----

ArrayList<BadBalls> balls;
Ball yours1;
Ball yours2;
String frame;
float mode, holding, sze, speed, rate, click;
int time;

void setup() {
  size(600, 600); //MUST BE SQUARE FOR PROPER DIFFICULTY
  frameRate(60); //Don't change this?
  //Audio
  minim = new Minim(this);
  player = minim.loadFile("LoadingScreen.wav");
  player2 = minim.loadFile("Gameplay.wav");
  player3 = minim.loadFile("WinningScreen.wav");
  player4 = minim.loadFile("LosingScreen.wav");
  aud1=0;
  aud2=0;
  aud3=0;
  //-----

  //Images
  dirs = loadImage("directions.PNG");
  ball = loadImage("ball.png");
  button1 = loadImage("button1.png");
  button2 = loadImage("button2.png");
  button3 = loadImage("button3.png");
  //button4 = loadImage("button4.png");
  //-----

  //Other
  balls = new ArrayList<BadBalls>();
  yours1 = new Ball(width/2-width/10, height/2, 50);
  yours2 = new Ball(width/2+width/10, height/2, 50);

  frame="dirs";
  mode=0;
  holding=0;
  sze=0;
  speed=0;
  rate=60;
  time=0;

  rectMode(CENTER);
  imageMode(CENTER);
  textAlign(CENTER);
  textSize(width/35);
  smooth();
  stroke(1);
}

void draw() {
  if (frame=="dirs") {
    dirs();
  }
  if (frame=="menu") {
    menu();
  } 
  if (frame=="play") {
    play();
  }
  if (frame=="win") {
    win();
  }
  if (frame=="lose") {
    lose();
  }
}

void mouseReleased() {
  if (frame=="dirs"){
    frame="menu";
  }
  if (frame=="menu") {
    if (abs(mouseX-width/2)<width/8 && abs(mouseY-height/4)<height/20) {
      mode=1;
      setPlay();
    }
    if (abs(mouseX-width/2)<width/8 && abs(mouseY-9*height/20)<height/20) {
      mode=2;
      setPlay();
    }
    if (abs(mouseX-width/2)<width/8 && abs(mouseY-13*height/20)<height/20) {
      mode=3;
      setPlay();
    }
  }
  if (frame=="play") {
    holding=0;
  }
  if (frame=="win"||frame=="lose") {
    if (abs(mouseX-width/2)<width/8 && abs(mouseY-height/2)<height/16) {
      playAgain();
    }
  }
}

void setPlay() {
  frame="play";
  player.pause();
  player2.rewind();
  player2.play();
  frameCount=0;
}

