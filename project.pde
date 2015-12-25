import ddf.minim.*;
AudioPlayer player;
Minim minim;//audio contexts
PImage image1, image2, image3, image4, image5, image6, image7, image8, image9, image10;
boolean firstcar4=true, firstcar5=true, win=false, beforegame=true, gamestart=false, timeSet=true;
int car1x=220, car1y=0, car2x=320, car2y=0, car3x=320, car3y=800, car4x=-100, car4y=-10, car5x=-100, car5y=-10;
int timerStart = 0, mill, minutes, seconds, hundredths, totalmiles=0;
int tree=100, treey, scene=0, killed=0;
int heartx[]=new int [3];
int hearty[]=new int [3];
int exist[]=new int[3];
int finishx=200, finishy=100;
void setup() {

  background(255);
  size(800, 1000);
  image1=loadImage("road-01.jpg");
  image2=loadImage("car1.png");
  image3=loadImage("car2.png");
  image4=loadImage("car3.png");
  image5=loadImage("car4.png");
  image6=loadImage("car5.png");
  image7=loadImage("heart.png");
  image8=loadImage("gameover.png");
  image9=loadImage("youwin.png");
  image10=loadImage("start.png");
  image(image1, 200, 0, 400, 1000);
  image(image2, 220, -83, 55, 125);
  image(image3, 310, -83, 55, 83);
  image(image4, car3y, car3y, 55, 83);
  for (int i=0; i<3; i++) {
    hearty[i]=100;
    exist[i]=1;
  }
  heartx[0]=600;
  heartx[1]=670;
  heartx[2]=740;
  image(image7, heartx[0], hearty[0], 60, 60);
  image(image7, heartx[1], hearty[1], 60, 60);
  image(image7, heartx[2], hearty[2], 60, 60);
  background(255);
  image(image1, 200, 0, 400, 1000);
  image(image1, 200, 0, 400, 1000);
  image(image10, 300, 400, 200, 200);
  minim = new Minim(this);
  player = minim.loadFile("music.mp3", 2048);
}
void draw() {
  if (timeSet) {
    timerStart=millis();
  }
  background(0, 139, 0);
  fill(0, 238, 0);

  if (scene<1000) {
    for (tree=100; tree<=900; tree+=200) {
      ellipse(100, tree+treey, 100, 100);
      ellipse(700, tree+treey, 100, 100);
    }
  } 
  for (int i=0; i<3; i++) {
    if (exist[i]==1) {
      image(image7, heartx[i], hearty[i], 60, 60);
    }
  }

  image(image1, 200, 0, 400, 1000);
  image(image4, car3x, car3y, 55, 83);
  fill(0, 238, 0);

  if (car1y<1000) {   
    image(image2, car1x, car1y, 55, 83);
    car1y-=5;
  } else {
    if (car2y>153&&car4y>153&&car5y>153)
      creatCar(1);
  }

  if (car2y<1000) {
    image(image3, car2x, car2y, 55, 83);
    car2y-=5;
  } else {
    if (car1y>153&&car4y>153&&car5y>153)
      creatCar(2);
  }
  if (seconds>9) {

    if (car4y<1000&&car4y>0) {
      image(image5, car4x, car4y, 55, 83);
      car4y-=5;
    } else {
      if (car1y>153&&car2y>153&&car5y>153)
        creatCar(3);
    }
  }
  if (seconds>15) {
    if (car5y<1000&&car5y>0) {
      image(image6, car5x, car5y, 55, 83);
      car5y-=5;
    } else {
      if (car1y>153&&car2y>153&&car4y>153)
        creatCar(4);
    }
  }

  if ((keyPressed == true) && (key == 'd')) {
    if (car3x<530) {
      car3x = car3x+20;
    }
  } 
  if ((keyPressed == true) && (key == 'a')) {
    if (car3x>210) {
      car3x = car3x-20;
    }
  }
  /*  println("car1 "+car1x);
   println("car2 "+car2x);
   println("car3 "+car3x);
   println("car4 "+car4x);
   println("car5 "+car5x);
   */
  if ((car3y<=car1y+60&&car1x+45>=car3x&&car1x-50<=car3x&&car3y>car1y-60)||(car3y<=car2y+60&&car2x+45>=car3x&&car2x-50<=car3x&&car3y>car2y-60)||(car3y<=car4y+60&&car4x+45>=car3x&&car4x-50<=car3x&&car3y>car4y-60)||(car3y<=car5y+60&&car5x+45>=car3x&&car5x-50<=car3x&&car3y>car5y-60)) {

    exist[killed]=0;
    killed++;
    car1y-=800;
    car2y-=800;
    car4y-=800;
    car5y-=800;
    delay(100);
  //  noLoop();
    //    println(killed);
  }
    if (totalmiles>36000) {
    fill(255, 0, 0);
    rect(finishx, finishy, 400, 20);
  }
  if ((keyPressed == true) && (key == 'w')) {
  //  loop();
    player.play();
    gamestart=true;
    car1y = car1y+30;
    car2y = car2y+30;
    car4y = car4y+30;
    car5y = car5y+30;
    scene=treey+=30;
    totalmiles+=30;
    //   println(scene);
    if (scene>1000) {
      treey=-800;
      scene=0;
    }
    if (totalmiles>36000) {

      finishy+=30;
    }
  } 
  if (gamestart) {
    if (!win) { 
      mill=(millis()-timerStart);
      timeSet=false;
    }
  } else {
    timerStart=millis();
  }
  seconds = mill / 1000;
  minutes = seconds / 60;
  seconds = seconds % 60;
  hundredths = mill / 10 % 100;

  fill(0, 0, 0);
  textSize(55);
  text(nf(minutes, 2, 0)+":"+nf(seconds, 2, 0)+":"+nf(hundredths, 2, 0), 50, 100);
  if (killed>=3) {
    image(image8, 0, 0, 800, 1000);
    player.close();
    minim.stop();
    super.stop();
  }
  if (finishy>car3y) {
    win=true; 
    background(255);
    image(image9, 0, 200, 800, 800);
    textSize(80);
    fill(0,206,209);
    text("your score:"+minutes+":"+seconds+":"+hundredths, 50, 150);
    player.close();
    minim.stop();
    super.stop();
  }

  if (beforegame) {

    background(255);
    image(image1, 200, 0, 400, 1000);
    image(image10, 300, 400, 200, 200);
    textSize(150);
    text("car   race", 90, 300);
  }

}
void creatCar(int j) {

  switch(j) {
  case 1:
    int i=(int)random(1, 5);
    switch(i) {
    case 1:
      car1x=220;
      car1y=0;
      break;
    case 2:
      car1x=320;
      car1y=0;
      break;
    case 3:
      car1x=420;
      car1y=0;
      break;
    case 4:
      car1x=530;
      car1y=0;
      break;
    }
    break;

  case 2:
    int l=(int)random(1, 5);
    switch(l) {
    case 1:
      car2x=220;
      car2y=0;
      break;
    case 2:
      car2x=320;
      car2y=0;
      break;
    case 3:
      car2x=420;
      car2y=0;
      break;
    case 4:
      car2x=530;
      car2y=0;
      break;
    }
    break;
  case 3:
    int k=(int)random(1, 5);
    switch(k) {
    case 1:
      car4x=220;
      car4y=0;
      break;
    case 2:
      car4x=320;
      car4y=0;
      break;
    case 3:
      car4x=420;
      car4y=0;
      break;
    case 4:
      car4x=530;
      car4y=0;
    }
    break;
  case 4:
    int p=(int)random(1, 5);
    switch(p) {
    case 1:
      car5x=220;
      car5y=0;
      break;
    case 2:
      car5x=320;
      car5y=0;
      break;
    case 3:
      car5x=420;
      car5y=0;
      break;
    case 4:
      car5x=530;
      car5y=0;
      break;
    }
    break;
  }
}

void keyPressed() {
  if (key == 'w') {
    loop();
  }
  if (key == ENTER) {   
    beforegame=false;
  }
}
