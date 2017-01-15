class Hero {
  float hp;
  int x = width/2;
  int y = height/2;
  int preX, preY;
  int speed = 5;
  int gunNum;
  String nowDirection = "Down";
  int nowDirectionNum; //用來傳送給player.shooted
  PImage img;
  PImage playerUp;
  PImage playerDown;
  PImage playerLeft;
  PImage playerRight;
  PImage [] rocketImg =new PImage [5];
  int [] rocketX =new int [5];
  int [] rocketY =new int [5];
  boolean shooting = false;
  
  boolean moving = false;
  int movingPassedTime, movingSavedTime;


  Hero(int x, int y ) {
    this.x = x;
    this.y = y;
    hp = 100;
    img = loadImage("img/player"+nowDirection+".png");
    playerUp = loadImage("img/playerUp.png");
    playerDown = loadImage("img/playerDown.png");
    playerLeft = loadImage("img/playerLeft.png");
    playerRight = loadImage("img/playerRight.png");
    for (int i=0; i<5; i++) {
      rocketImg[i]=loadImage("img/rocket.png");
      rocketX[i]=x;
      rocketY[i]=y;
    }
  }

  void display() {
    if(hp>=100){
      hp=100;
     }
    fill(#ff0000);//血量紅色
    image(img, x, y);
    rect(x-img.width+10, y-15, hp/1.5, 5);//HERO血量
    if(hp<=0){
      gameState = GAME_OVER;
    }
  }

  void move(boolean up, boolean down, boolean left, boolean right) {
    preX = x;
    preY = y;
    if (up) {
      y-= speed;
      img = playerUp;
      nowDirectionNum = Direction.UP;
    }
    if (down) {
      y+= speed;
      img = playerDown;
      nowDirectionNum = Direction.DOWN;
    }
    if (left) {
      x-= speed;
      img = playerLeft;
      nowDirectionNum = Direction.LEFT;
    }
    if (right) {
      x+= speed;
      img = playerRight;
      nowDirectionNum = Direction.RIGHT;
    }
    collisionZombieDetection();
//---------------------sounds--------------------------//    
    if(x!=preX || y!=preY){
      moving = true;
    }else{moving = false;}
    if(movingTimer(500,moving)){
      movingSounds.trigger();
    }
//---------------------sounds--------------------------//
  }
 void collisionZombieDetection(){ //0108 update
  //殭屍碰到HERO的碰撞偵測
  for(int i=0;i<zombieNow; i++){
  int direction = isHitDirection(x,y,img.width,img.height,zombieArray[i].x,zombieArray[i].y,zombieArray[i].img.width,zombieArray[i].img.height,0);
  switch(direction){
    case Direction.LEFT:
     x += speed;
     break;
    case Direction.RIGHT:
     x -= speed;
     break;
    case Direction.UP:
     y += speed;
     break;
    case Direction.DOWN:
     y -= speed;
     break;
  }
  }
} 
  void shooting(int gunNum) {
    float i = random(-15,15);
    this.gunNum = gunNum;
    if (gunNum ==1 || gunNum==2) {
      if (nowDirectionNum==Direction.UP) {
        line(x+30, y-20, x+30+i, y-20-gunArray[gunNum].distance);
      }
      if (nowDirectionNum==Direction.DOWN) {
        line(x+5, y+50, x+5+i, y+50+gunArray[gunNum].distance);
      }
      if (nowDirectionNum==Direction.LEFT) {
        line(x-20-gunArray[gunNum].distance, y+10+i, x-20, y+10);
      }
      if (nowDirectionNum==Direction.RIGHT) {
        line(x+60, y+25, x+60+gunArray[gunNum].distance, y+25+i);
      }
    }
    if (gunNum==3) {
      if (nowDirectionNum==Direction.UP) {
        line(x+30, y-20, x+30+i, y-20-gunArray[gunNum].distance);
        line(x+30+5, y-20, x+30+30+i, y-20-gunArray[gunNum].distance);
        line(x+30-5, y-20, x+30-30+i, y-20-gunArray[gunNum].distance);
      }
      if (nowDirectionNum==Direction.DOWN) {
        line(x+5, y+50, x+5+i, y+50+gunArray[gunNum].distance);
        line(x+5+5, y+50, x+5+30+i, y+50+gunArray[gunNum].distance);
        line(x+5-5, y+50, x+5-30+i, y+50+gunArray[gunNum].distance);
      }
      if (nowDirectionNum==Direction.LEFT) {
        line(x-20, y+10, x-20-gunArray[gunNum].distance, y+10+i);
        line(x-20, y+10-5, x-20-gunArray[gunNum].distance, y+10-30+i);
        line(x-20, y+10+5, x-20-gunArray[gunNum].distance, y+10+30+i);
      }
      if (nowDirectionNum==Direction.RIGHT) {
        line(x+60, y+25, x+60+gunArray[gunNum].distance, y+25+i);
        line(x+60, y+25-5, x+60+gunArray[gunNum].distance, y+25-30+i);
        line(x+60, y+25+5, x+60+gunArray[gunNum].distance, y+25+30+i);
      }
    }
  }
  
boolean movingTimer(int totalTime, boolean startNow){  //startNow是指你要開始計時的時間點
  if(startNow ==true){
    movingPassedTime = millis()-movingSavedTime;
  }
  if(movingPassedTime>totalTime){
      movingSavedTime = millis();
      return true;
  }
  return false;
  
}  
  
}