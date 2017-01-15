public class Zombie{
float hp;
int x,y;
int preX, preY;
float speed = 1;
float preSpeedX, preSpeedY; //0104用來紀錄殭屍上一秒的方向 不讓她每一秒都改變方向 讓殭屍可以頓頓的
int direction;
boolean shotGunShooted; 
PImage img, img2;
PImage zombieUp, zombieUp2;
PImage zombieDown, zombieDown2;
PImage zombieLeft, zombieLeft2;
PImage zombieRight;
PImage zombieRight2, boss;
int passedTime, savedTime; // 殭屍扣主角的血
boolean startNowHeorHit;// 殭屍扣主角的血
int zombieHitPassedTime, zombieHitSavedTime;//殭屍被子彈打到
boolean startNow,shooted = false;
boolean shootStop = false;
boolean stopped, mostG8;
int power;

int r = 5;
int stopDirection;
int directMove; //被卡住的時候決定一個方向

Zombie(int state, int num){
  int z = (num+1) % 5 ;
  switch(z){
    case 0:
    hp = 300;
    speed *= 3;
    power = 20;
    img = loadImage("img/strongZombieDown.png");
    zombieUp = loadImage("img/strongZombieUp.png");
    zombieUp2 = loadImage("img/strongZombieUp2.png");
    zombieDown = loadImage("img/strongZombieDown.png");
    zombieDown2 = loadImage("img/strongZombieDown2.png");
    zombieLeft = loadImage("img/strongZombieLeft.png");
    zombieLeft2 = loadImage("img/strongZombieLeft2.png");
    zombieRight = loadImage("img/strongZombieRight.png");
    zombieRight2 = loadImage("img/strongZombieRight2.png");
    break;
    default:
    hp = 100;
    power =10;
    img = loadImage("img/zombieDown.png");
    zombieUp = loadImage("img/zombieUp.png");
    zombieUp2 = loadImage("img/zombieUp2.png");
    zombieDown = loadImage("img/zombieDown.png");
    zombieDown2 = loadImage("img/zombieDown2.png");
    zombieLeft = loadImage("img/zombieLeft.png");
    zombieLeft2 = loadImage("img/zombieLeft2.png");
    zombieRight = loadImage("img/zombieRight.png");
    zombieRight2 = loadImage("img/zombieRight2.png");
    break;
  }
  switch(state){
    case 0:
    int r = floor(random(0,2));
    if(r==0){
    x=5;
    y=315;
    }else{
      x=width-5;
      y=314;
    }
    
    break;
    
    case 1:
    r = floor(random(0,2));
    if(r==0){
    x=5;
    }else{
      x=width-5;
    }
    y=height/2;
    break;
    
    
    case 2:
      x=5;
      y= 180;
    
    break;
  }
  
}

void display(){
  if(shootStop==true){
    image(img2,x,y);
  }else{image(img,x,y);}
}
void move(int type){ //0108 update
  r = collisionDetection(0);
  if(stopped==true){ 
    moveWithBlock( r );
  }
  if(stopped != true){
    if(type==0){ 
      pureMove();
    }else{
    x += preSpeedX;
    y += preSpeedY;
    }
    if(r<4){ 
    preSpeedX = 0;
    preSpeedY = 0;
    stopped = true;
    switch(r){
      case 0:
      x += speed;
      preSpeedX = speed;
      break;
      case 1:
      x -= speed;
      preSpeedX -= speed;
      break;
      case 2:
      y += speed;
      preSpeedY = speed;
      break;
      case 3:
      y -= speed;
      preSpeedX = -speed;
      break;
    }
    }
  }
}
int collisionDetection(int range){
  for(int i=0; i<blockMax; i++){
    int check = isHitDirection(x, y,img.width,img.height,blockArray[i].x,blockArray[i].y,blockArray[i].img.width,blockArray[i].img.height,range);
    if(check != 4){
      return check;
    }
  }
  stopped = false;
  return 4;
}
void pureMove(){ 
  preSpeedX = 0;
  preSpeedY = 0;
  if(x < hero.x-2 || x > hero.x+2){ // 防止抖動 0105 update
    if(x<hero.x){
      preX =x;
      x += speed;
      img = zombieRight;
      img2 = zombieRight2;
      preSpeedX = speed;
    }else{
      preX =x;
      x -= speed;
      img = zombieLeft;
      img2 = zombieLeft2;
      preSpeedX = -speed;
    }
  }  
  if(y < hero.y-2 || y > hero.y+2){ // 防止抖動 0105 update
    if(y<hero.y){
      preY =y;
      y += speed;
      img = zombieDown;
      img2 = zombieDown2;
      preSpeedY = speed;
    }else{
      preY = y;
      y -= speed;
      img = zombieUp;
      img2 = zombieUp2;
      preSpeedY = -speed;
    }
  }
  boundaryD();
}
void moveWithBlock(int direction){
  //殭屍碰到block的碰撞偵測 //0104 update
  preSpeedX = 0;
  preSpeedY = 0;
  stopDirection = direction;
  switch(direction){
    case Direction.DOWN:
    case Direction.UP:
    if(x == hero.x){
      directMove = floor(random(0,2));
      mostG8(direction);
    }else{
    if(x<hero.x){x++; img = zombieRight;preSpeedX = speed;}else{x--; img = zombieLeft;preSpeedX = -speed;}
    }
    break;
    case Direction.RIGHT:
    case Direction.LEFT:
    if(y == hero.y){
      directMove = floor(random(2,4));
      mostG8(direction);
    }else{
    if(y<hero.y){y++; img = zombieDown;preSpeedY = speed;}else{y--; img = zombieUp;preSpeedY = -speed;}
    }
    break;
  }
}
void mostG8(int direction){
  preSpeedX = 0;
  preSpeedY = 0;
  mostG8 = true;
  int d = directMove;
  int range =2;
  switch(direction){
    case Direction.LEFT:
     if(d==2){y--; preSpeedY = -speed; img = zombieUp;}else{y++; preSpeedY = speed; img = zombieDown;}
     if(collisionDetection(range)==4){mostG8 = false;}
     break;
    case Direction.RIGHT:
     if(d==2){y--; preSpeedY = -speed; img = zombieUp;}else{y++; preSpeedY = speed; img = zombieDown;}
     if(collisionDetection(range)==4){mostG8 = false;}
     break;
    case Direction.UP:
     if(d==0){x--; preSpeedX = -speed; img = zombieLeft;}else{x++; preSpeedX = speed; img = zombieRight;}
     if(collisionDetection(range)==4){mostG8 = false;}
     break;
    case Direction.DOWN:
     if(d==0){x--; preSpeedX = -speed; img = zombieLeft;}else{x++; preSpeedX = speed; img = zombieRight;}
     if(collisionDetection(range)==4){mostG8 = false;}
     break;
  }
}
void collisionHeroDetection(){ //0108 update
  //殭屍碰到HERO的碰撞偵測
  int direction = isHitDirection(x,y,img.width,img.height,hero.x,hero.y,hero.img.width,hero.img.height,0);
  switch(direction){
    case Direction.LEFT:
     x += speed;
     preSpeedX = speed;
     preSpeedY = 0;
     startNow = true;
     if(attackTimer(500,startNow)){
       hero.hp-=power;//被殭屍打到扣血
     }
     break;
    case Direction.RIGHT:
     x -= speed;
     preSpeedX = -speed;
     preSpeedY = 0;
     startNow = true;
     if(attackTimer(500,startNow)){
       hero.hp-=power;//被殭屍打到扣血
     }
     break;
    case Direction.UP:
     y += speed;
     preSpeedY = speed;
     preSpeedX = 0;
     startNow = true;
     if(attackTimer(500,startNow)){
       hero.hp-=power;//被殭屍打到扣血
     }
     break;
    case Direction.DOWN:
     y -= speed;
     preSpeedY = -speed;
     preSpeedX = 0;
     startNow = true;
     if(attackTimer(500,startNow)){
       hero.hp-=power;//被殭屍打到扣血
     }
     break;
  }
  
}
void collisionZombieDetection(int i){ //0108 update
  //殭屍碰到HERO的碰撞偵測
  for(int j=0;j<zombieNow; j++){
    if(i!=j){
      int direction = isHitDirection(x,y,img.width,img.height,zombieArray[j].x,zombieArray[j].y,zombieArray[j].img.width,zombieArray[j].img.height,0);
      switch(direction){
        case Direction.LEFT:
         x += speed;
         preSpeedX = speed;
         preSpeedY = 0;
         break;
        case Direction.RIGHT:
         x -= speed;
         preSpeedX = -speed;
         preSpeedY = 0;
         break;
        case Direction.UP:
         y += speed;
         preSpeedY = speed;
         preSpeedX = 0;
         break;
        case Direction.DOWN:
         y -= speed;
         preSpeedY = -speed;
         preSpeedX = 0;
         break;
      }
    }
  }
  boundaryD();
}
void hpCheck(int num){
  int z = (num+1) % 5 ;
  //switch(z){
  //  case 0:
  //  score += 500;
  //  break;
  //  default:
  //  score +=100;
  //  break;
  //  }
    if(hp <= 0&& z==0){
    big =true;
        bigx = x;
        bigy = y;
    x = width;
    y = height;
    switch(z){
    case 0:
    score += 500;
    break;
    default:
    score +=100;
    break;
    }
    }
  if(hp <= 0&& z!=0){
    dead =true;
        deadx = x;
        deady = y;
    x = width;
    y = height;
    switch(z){
    case 0:
    score += 500;
    break;
    default:
    score +=100;
    break;
    }
  }
}
void boundaryD(){
  if(x+img.width>=width){
      x= width-img.width;
    }
    if(x<=0){
      x = 0;
    }
    if(y+img.height>=height){
      y =height-img.height;
    }
    if(y<=0){
      y=0;
    }
  switch(stageState){
    case 0:
      if(x<90 && x>0){
        if(y<=280){
          y=280;
        }
        if(y+img.height>420){
          y=420-img.height;
        }
      }
      if(x<1080 && x>990){
        if(y<=280){
          y=280;
        }
        if(y+img.height>420){
          y=420-img.height;
        }
      }
    break;
    case 1:
      if(y<240){
        y=240;
      }
    break;
    case 2: 
    if(x<55 && x>0){
      if(y<=170){
        y=170;
      }
      if(y+img.height>270){
        y=270-img.height;
      }
    }
    break;
  }
}

boolean shooted(int heroDirection, int zombieNum, int gunNum,int gunFourDectection){
  switch(heroDirection){
    case Direction.UP:
     if(zombieArray[zombieNum].x+zombieArray[zombieNum].img.width > hero.x+30 -gunFourDectection && hero.x+30+gunFourDectection > zombieArray[zombieNum].x){
       if(zombieArray[zombieNum].y+zombieArray[zombieNum].img.height > hero.y-20-gunArray[gunNum].distance && hero.y-20>zombieArray[zombieNum].y){
         return true;
       }
     }
    break;
    case Direction.DOWN:
    if(zombieArray[zombieNum].x+zombieArray[zombieNum].img.width > hero.x+5-gunFourDectection && hero.x+5+gunFourDectection > zombieArray[zombieNum].x){
      if(zombieArray[zombieNum].y < hero.y+hero.img.height+20+gunArray[gunNum].distance&&hero.y+hero.img.height+20<zombieArray[zombieNum].y+zombieArray[zombieNum].img.height){
        return true;
      }
    }
    break;
    case Direction.LEFT:
    if(zombieArray[zombieNum].y+zombieArray[zombieNum].img.height > hero.y+10-gunFourDectection && hero.y+10+gunFourDectection> zombieArray[zombieNum].y){
      if(zombieArray[zombieNum].x+zombieArray[zombieNum].img.width > hero.x-20-gunArray[gunNum].distance &&hero.x-20>zombieArray[zombieNum].x){
        return true;
      }
    }
    break;
    case Direction.RIGHT:
    if(zombieArray[zombieNum].y+zombieArray[zombieNum].img.height > hero.y+25-gunFourDectection && hero.y+25+gunFourDectection > zombieArray[zombieNum].y){
      if(zombieArray[zombieNum].x < hero.x+hero.img.width+20+gunArray[gunNum].distance&&hero.x+hero.img.width+20< zombieArray[zombieNum].x+zombieArray[zombieNum].img.width ){
        return true;
      }
    }
    break;
  }
  return false;
} 
//---------------------計時器--殭屍攻擊hero---//  
boolean attackTimer(int totalTime, boolean startNowHeorHit){  //startNow是指你要開始計時的時間點
//for(int i = 0 ; i< zombieNow; i++){
  if(startNowHeorHit ==true){
    passedTime = millis()-savedTime;
  }
  if(passedTime>totalTime){
      savedTime = millis();
      return true;
  }
  return false;
}
//---------------------計時器--------------------------//
 //殭屍被打到的硬直   
boolean zombieHitimer(int totalTime, boolean startNow){  //startNow是指你要開始計時的時間點
  if(startNow ==true){
    zombieHitPassedTime = millis()-zombieHitSavedTime;
  }
  if(zombieHitPassedTime>totalTime){
      zombieHitSavedTime = millis();
      return true;
  }
  return false;
}
 //殭屍被打到的硬直   
//---------------------計時器--------------------------//
}