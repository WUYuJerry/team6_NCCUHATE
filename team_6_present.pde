//槍的射速計時器加入
//聲音加入（腳步聲、槍聲、油桶爆炸聲）
//
int gameState =0;
    String gunUL;
final int GAME_START = 0;
final int GAME_RUN = 1;
final int GAME_CLEAR = 2;
final int GAME_OVER = 3;
final int GAME_WIN = 4;

boolean uziUnlock = false;
boolean shotgunUnlock = false;
boolean barrelUnlock = false;
boolean rocketUnlock = false;
boolean fire;
int firex,firey;
boolean dead;
int deadx,deady;
PImage[] zombieLeftDying = new PImage[31];
int zombieLeftDyingnowFrame = 0;
PImage[] strongZombieLeftDying = new PImage[31];
int strongZombieLeftDyingnowFrame = 0;
boolean big;
int bigx, bigy;

PFont myFont;
PImage bg, bg0, bg1,bg2,cake,testpaper,gas;
PImage washer;
PImage stageClear;
PImage start;
int zombieWave = 1;
int waveNum;
int score = 0;
int scorePlus = 100;
boolean isMovingUp;
boolean isMovingDown;
boolean isMovingLeft;
boolean isMovingRight;
PImage block;
float bX1, bY1, bX2, bY2;
//---------------------sounds--------------------------//
import ddf.minim.*;
Minim minim;
AudioPlayer bgSounds;
AudioPlayer washerbgSounds;
AudioPlayer kitchenbgSounds;
AudioPlayer zombieSounds;
AudioSample shotGunSounds;
AudioSample uziGunSounds;
AudioSample pistolGunSounds;
AudioSample movingSounds;
AudioSample explosionSounds;
AudioSample canPlaceSounds;//放油桶音效
AudioSample treasurePickUpSounds;
AudioSample rocketSounds; //發射音效
//---------------------sounds--------------------------//

//---------------------計時器--------------------------//
int gunPassedTime, gunSavedTime;
int treasurePassedTime, treasureSavedTime;
//---------------------計時器--------------------------//

Hero hero;

int zombieMax = 300;
int zombieNow = 0;
int shootedNumZ;
float distanceZ;
Zombie[] zombieArray = new Zombie[zombieMax];

int gunMax =6;
int gunLimit = 6;//第n支槍還不能用
int gunNow = 1;
Gun[] gunArray = new Gun[gunMax];

int canMax =100;
int canNow =0;
int shootedNumC;
float distanceC;
Can[] canArray=new Can[canMax];

int rocketMax =50;
int rocketNow=0;
Rocket [] rocketArray=new Rocket[rocketMax];
boolean setRocket;

JSONObject json;
int stageState = -1; //遊戲關卡 用來變換場景
int blockMax = 10; //每關的block數量 預設第一關3個
int bX[] = new int[blockMax]; //每個block的x
int bY[] = new int[blockMax];
Block[] blockArray = new Block[blockMax];

Treasure treasure;

PImage[] startGame1 = new PImage[194];

int startGame1nowFrame = 0;

PImage[] canFire = new PImage[21];
int canFirenowFrame = 0;

class Direction
{
  static final int LEFT = 0;
  static final int RIGHT = 1;
  static final int UP = 2;
  static final int DOWN = 3;
}

void setup() {
  size(1080, 720);
  myFont = createFont("8bit.ttf",30);
  textFont(myFont);
  hero = new Hero(width/2, height/2);
  treasure = new Treasure();
  
  frameRate(60);
  hero.nowDirectionNum=Direction.DOWN;
//---------------------sounds--------------------------//
  minim = new Minim(this);
  kitchenbgSounds = minim.loadFile("sounds/kitchenBG.mp3");
  washerbgSounds = minim.loadFile("sounds/WashingMachineBackground.mp3");
  zombieSounds = minim.loadFile("sounds/zombieSounds.mp3");
  shotGunSounds = minim.loadSample("sounds/Fire.ShotGun.mp3",256);
  uziGunSounds = minim.loadSample("sounds/Fire.UZI.mp3",256);
  pistolGunSounds = minim.loadSample("sounds/Fire.Pistol.mp3",256);
  movingSounds = minim.loadSample("sounds/moving.wav",256);
  explosionSounds = minim.loadSample("sounds/Explosion2.wav",256);
  canPlaceSounds = minim.loadSample("sounds/Barrel.Place.mp3",256);
  treasurePickUpSounds = minim.loadSample("sounds/Pickup.Treasure.mp3",256);
  rocketSounds = minim.loadSample("sounds/rocketSound.mp3",256);
//---------------------sounds--------------------------//
  gunArray[gunNow] = new Gun(gunNow); //預設使用第1隻槍
  changeStage();
  bg = loadImage("img/washerBG.png");
  bg0 = loadImage("img/washerBG.png");
  bg1 = loadImage("img/woodfloorBG.png");
  bg2 = loadImage("img/kitchenBG.png");
  stageClear = loadImage("img/gameclear.jpg");
  cake =  loadImage("img/cake.png");
  testpaper = loadImage("img/testpaper.png");
  gas =  loadImage("img/gas.png");
  start = loadImage("img/NCCUHATE.png");
  bgSounds.play();
  zombieSounds.loop();
  
  for(int i = 0; i < 194; i++){
    startGame1[i] = loadImage("startGame1/"+i+".png" );
  }  
  for(int i = 0; i < 21; i++){
    canFire[i] = loadImage("canFire/"+i+".png" );
  }
  for(int i = 0; i < 31; i++){
    zombieLeftDying[i] = loadImage("zombieLeftDying/"+i+".png" );
  }
  for(int i = 0; i < 31; i++){
    strongZombieLeftDying[i] = loadImage("strongZombieLeftDying/"+i+".png" );
  }
  frameRate(30);
}

void draw() {
  switch(gameState){
    case GAME_START:
    // startGame1
  image(startGame1[startGame1nowFrame], 0, 0);
  startGame1nowFrame ++;
  if(startGame1nowFrame >= 193){
    startGame1nowFrame = 193;
  }
  if(startGame1nowFrame == 193){
    image(start,0,0);
  }
    
    stageState = 0;
    zombieNow = 0;
    score = 0;
    hero.hp = 100;
    gunNow = 1;
    gunArray[2] = null;
    gunArray[3] = null;
    gunArray[4] = null;
    gunArray[5] = null;
    if(mousePressed){gameState = GAME_RUN;}
    break;
  case GAME_RUN :
    switch(stageState){
      case 0:
      bg = bg0;
      treasure.img = gas;
    
      break;
      case 1:
      bg = bg1;
      treasure.img = testpaper;
      break;
      case 2:
      bg = bg2;
      treasure.img = cake;
      break;
  }
  image(bg,0,0);
  if(fire){
  image(canFire[canFirenowFrame], firex-20, firey-20,150,150); // 再設定canX, canY
  canFirenowFrame ++;
  if(canFirenowFrame >= 20){
    canFirenowFrame = 20;
  }
  if(canFirenowFrame == 20){
    fire = false;
    firex=-1000;
    firey=-1000;
    canFirenowFrame =0;
  }
  }
  if(dead){
  image(zombieLeftDying[zombieLeftDyingnowFrame], deadx-20, deady,50,27); // 再設定playerX, playerY
  zombieLeftDyingnowFrame ++;
  if(zombieLeftDyingnowFrame >= 30){
    zombieLeftDyingnowFrame = 30;
  }
  if(zombieLeftDyingnowFrame == 30){
    zombieLeftDyingnowFrame =0;
    dead = false;
    deadx= -1000;
    deady= -1000;
  }
  }
  if(big){
  image(strongZombieLeftDying[strongZombieLeftDyingnowFrame], bigx+20, bigy+50,80,40); // 再設定playerX, playerY
  strongZombieLeftDyingnowFrame ++;
  if(strongZombieLeftDyingnowFrame >= 30){
    strongZombieLeftDyingnowFrame = 30;
  }
  if(strongZombieLeftDyingnowFrame == 30){
    strongZombieLeftDyingnowFrame =0;
    big = false;
    bigx= -1000;
    bigy= -1000;
  }
  }
  
  //if(){
  //zombieWave = waveNum + stageState*3;
  //}
  switch(zombieWave){
    case 1 :
      zombieMax = 5;
      int zspawn = floor(random(0,60));
      if(zspawn == 1){
        if (zombieNow < zombieMax) {
          zombieArray[zombieNow] = new Zombie(0,zombieNow);
          zombieNow++;
        }
      }
      if(zombieArray[zombieMax-1]!=null){   println(zombieMax);
        boolean wave1Clear = true;
        for(int i = 0; i<zombieMax; i++){
          if(zombieArray[i].x != width && zombieArray[i].y!=height){
            wave1Clear = false;
          }
        }
        if(wave1Clear==true){
          zombieWave = 2;
          zombieNow = 0;
          println("clear");
        }
      }
      break;
    case 2 :
    println("case2");
      zombieMax = 6;
      zspawn = floor(random(0,30));
      if(zspawn == 1){
        if (zombieNow < zombieMax) {
          zombieArray[zombieNow] = new Zombie(0, zombieNow);
          zombieNow++;
        }
      }
      if(zombieArray[zombieMax-1]!=null){   println(zombieMax);
        boolean wave1Clear = true;
        for(int i = 0; i<zombieMax; i++){
          if(zombieArray[i].x != width && zombieArray[i].y!=height){
            wave1Clear = false;
          }
        }
        if(wave1Clear==true){
          zombieWave = 3;
          zombieNow = 0;
        }
      }
      break;
      case 3 :
      println("case3");
      zombieMax = 7;
      zspawn = floor(random(0,20));
      if(zspawn == 1){
        if (zombieNow < zombieMax) {
          zombieArray[zombieNow] = new Zombie(0,zombieNow);
          zombieNow++;
        }
      }
      if(zombieArray[zombieMax-1]!=null){   
        boolean wave1Clear = true;
        for(int i = 0; i<zombieMax; i++){
          if(zombieArray[i].x != width && zombieArray[i].y!=height){
            wave1Clear = false;
          }
        }
        if(wave1Clear==true){
          gameState = GAME_CLEAR;
          zombieNow = 0;
          //changeStage();
          println("clear");
        }
      }
      break;
      case 4 :
      println("case 4");
      zombieMax = 8;
      zspawn = floor(random(0,40));
      if(zspawn == 1){
        if (zombieNow < zombieMax) {
          zombieArray[zombieNow] = new Zombie(1,zombieNow);
          zombieNow++;
        }
      }
      if(zombieArray[zombieMax-1]!=null){   
        boolean wave1Clear = true;
        for(int i = 0; i<zombieMax; i++){
          if(zombieArray[i].x != width && zombieArray[i].y!=height){
            wave1Clear = false;
          }
        }
        if(wave1Clear==true){
          zombieWave = 5;
          zombieNow = 0;
          println("555555");
        }
      }
      break;
       case 5 :
      zombieMax = 9;
      zspawn = floor(random(0,39));
      if(zspawn == 1){
        if (zombieNow < zombieMax) {
          zombieArray[zombieNow] = new Zombie(1,zombieNow);
          zombieNow++;
        }
      }
      if(zombieArray[zombieMax-1]!=null){   
        boolean wave1Clear = true;
        for(int i = 0; i<zombieMax; i++){
          if(zombieArray[i].x != width && zombieArray[i].y!=height){
            wave1Clear = false;
          }
        }
        if(wave1Clear==true){
          zombieWave = 6;
          zombieNow = 0;
          println("6666666");
        }
      }
      break;
      case 6 :
      zombieMax = 10;
      zspawn = floor(random(0,30));
      if(zspawn == 1){
        if (zombieNow < zombieMax) {
          zombieArray[zombieNow] = new Zombie(1,zombieNow);
          zombieNow++;
        }
      }
      if(zombieArray[zombieMax-1]!=null){   
        boolean wave1Clear = true;
        for(int i = 0; i<zombieMax; i++){
          if(zombieArray[i].x != width && zombieArray[i].y!=height){
            wave1Clear = false;
          }
        }
        if(wave1Clear==true){
          zombieNow = 0;
          gameState = GAME_CLEAR;
        }
      }
      break;
    case 7 :
      zombieMax = 11;
      zspawn = floor(random(0,20));
      if(zspawn == 1){
        if (zombieNow < zombieMax) {
          zombieArray[zombieNow] = new Zombie(2,zombieNow);
          zombieNow++;
        }
      }
      if(zombieArray[zombieMax-1]!=null){   
        boolean wave1Clear = true;
        for(int i = 0; i<zombieMax; i++){
          if(zombieArray[i].x != width && zombieArray[i].y!=height){
            wave1Clear = false;
          }
        }
        if(wave1Clear==true){
          zombieWave = 8;
          zombieNow = 0;
          println("888888");
        }
      }
      break;
    case 8 :
      zombieMax = 12;
      zspawn = floor(random(0,19));
      if(zspawn == 1){
        if (zombieNow < zombieMax) {
          zombieArray[zombieNow] = new Zombie(2,zombieNow);
          zombieNow++;
        }
      }
      if(zombieArray[zombieMax-1]!=null){   
        boolean wave1Clear = true;
        for(int i = 0; i<zombieMax; i++){
          if(zombieArray[i].x != width && zombieArray[i].y!=height){
            wave1Clear = false;
          }
        }
        if(wave1Clear==true){
          zombieWave = 9;
          zombieNow = 0;
          println("9999999999");
        }
      }
      break;
    case 9 :
      zombieMax = 13;
      zspawn = floor(random(0,10));
      if(zspawn == 1){
        if (zombieNow < zombieMax) {
          zombieArray[zombieNow] = new Zombie(2,zombieNow);
          zombieNow++;
        }
      }
      if(zombieArray[zombieMax-1]!=null){   
        boolean wave1Clear = true;
        for(int i = 0; i<zombieMax; i++){
          if(zombieArray[i].x != width || zombieArray[i].y!=height){
            wave1Clear = false;
          }
        }
        if(wave1Clear==true){
          gameState = GAME_WIN;
          
        }
      }
      break;
      
  }
  //Treasure
  treasure.display();
  treasure.eaten();
  if(treasureTimer(5000,treasure.eaten())==true){
    treasure = new Treasure();
  }
  if(treasure.eaten() == true){
    treasure.textState = true;
    if(frameCount-treasure.textFrameCount>=120){
      treasure.textState = false;
    }
    if(treasure.textState == true){

    }
  }
  
  //Hero
  hero.display();
  hero.move(isMovingUp, isMovingDown, isMovingLeft, isMovingRight);

  //Gun
  if (gunArray[gunNow] != null) {
    gunArray[gunNow].display();
  }
  // 
  for (int i=0; i< rocketNow; i++) {
    rocketArray[i].display();
    rocketArray[i].move(rocketArray[i].d);
  }

  //can
  for (int i=0; i<canNow; i++) {
    canArray[i].display();
  }
  //當射擊can時，如果殭屍同時在can的方圓10pixle內，則can爆炸&殭屍死掉(can&殭屍在畫面外)
    for (int j=0; j<canNow; j++) {
      canArray[j].shooted = false;
      if(canArray[j].x!=width && canArray[j].y!=height){
      if (hero.shooting) {
        if(gunNow!=4){
        if (canArray[j].shooted (hero.nowDirectionNum, j, gunArray[gunNow].num, gunArray[gunNow].range) ) {
              canArray[j].shooted = true;
        }
        }
      }
      }
      for(int k=0;k<rocketNow;k++){
      if(gunNow==5&& rocketArray[k]!=null){
      if(isHit(canArray[j].x, canArray[j].y, canArray[j].img.width, canArray[j].img.height, rocketArray[k].x-20, rocketArray[k].y-20, rocketArray[k].img.width+40, rocketArray[k].img.height+40)==true)
      {
        rocketArray[k].x = width;
        rocketArray[k].y = height;
        canArray[j].shooted = true;
      }
    }
  }
    }
  //Zombie
  for (int i=0; i<zombieNow; i++) {
    zombieArray[i].shooted = false;    
    if (zombieArray[i].x != width && zombieArray[i].y != height) {
      if(zombieArray[i].mostG8!=true){
        if(zombieArray[i].shootStop==false){
        zombieArray[i].move(floor ( random(0,3)) );
      }
      }else{
        zombieArray[i].mostG8(zombieArray[i].stopDirection);
      }
      zombieArray[i].collisionHeroDetection(); //0108 update
      zombieArray[i].collisionZombieDetection(i); //0108 update
      zombieArray[i].display();
      zombieArray[i].hpCheck(i);
          
    //殭屍被打到的硬直   
    if(zombieArray[i].zombieHitimer(300,zombieArray[i].shootStop)){
        zombieArray[i].shootStop = false;
      }
    //殭屍被打到的硬直 
    if (hero.shooting) {
      if (zombieArray[i].shooted (hero.nowDirectionNum, i, gunArray[gunNow].num, gunArray[gunNow].range)) {
        zombieArray[i].shooted = true;
      }
    }
    }
    for(int j=0;j<rocketNow;j++){
      if(gunNow==5&& rocketArray[j]!=null){
      if(isHit(zombieArray[i].x, zombieArray[i].y, zombieArray[i].img.width, zombieArray[i].img.height, rocketArray[j].x-20, rocketArray[j].y-20, rocketArray[j].img.width+40, rocketArray[j].img.height+40)==true)
      {
        rocketArray[j].x = width;
        rocketArray[j].y = height;
        
        dead =true;
        deadx = zombieArray[i].x;
        deady = zombieArray[i].y;
        zombieArray[i].x = width;
        zombieArray[i].y = height;
      }  
    }
  }
  }
  distanceZ = 100000;
  for(int i=0; i<zombieNow; i++){ //0107 update 射最近的那隻殭屍 
    if(zombieArray[i].shooted== true){
      float a = dist(zombieArray[i].x,zombieArray[i].y,hero.x,hero.y);
      if(a <= distanceZ){
      distanceZ = a;
      shootedNumZ =  i;
      }
    }
  }
  distanceC = 100000;
  for(int i=0; i<canNow; i++){  //0107 update 射最近的那個can
  if(canArray[i].shooted == true){
      float a = dist(canArray[i].x,canArray[i].y,hero.x,hero.y);
      if(a <= distanceC){
      distanceC = a;
      shootedNumC =  i;
      }
    }
  }
  if(hero.shooting == true ){
    if(zombieArray[shootedNumZ] != null && canArray[shootedNumC] != null){
      if(zombieArray[shootedNumZ].shooted!=true  && canArray[shootedNumC].shooted == true){
        for (int i=0; i<zombieNow; i++) {
          if (isHit(zombieArray[i].x, zombieArray[i].y, zombieArray[i].img.width, zombieArray[i].img.height, canArray[shootedNumC].x-50, canArray[shootedNumC].y-50, canArray[shootedNumC].img.width+100, canArray[shootedNumC].img.height+100)) {
            dead =true;
        deadx = zombieArray[i].x;
        deady = zombieArray[i].y;
            zombieArray[i].x = width;
            zombieArray[i].y = height;
          }
        }
        
        //---------------------sounds--------------------------//
        if(canArray[shootedNumC].x != width &&canArray[shootedNumC].y != height){
        explosionSounds.trigger();
        }
        //---------------------sounds--------------------------//
        println("123");
        fire =true;
        firex=canArray[shootedNumC].x;
        firey=canArray[shootedNumC].y;
        canArray[shootedNumC].x = width;
        canArray[shootedNumC].y = height;
    
        hero.shooting = false;
        canArray[shootedNumC].shooted = false;
      }else
      if(canArray[shootedNumC].shooted != true&& zombieArray[shootedNumZ].shooted == true){
        zombieArray[shootedNumZ].hp -= gunArray[gunNow].power;
        hero.shooting = false;
                      
        //殭屍被打到的硬直  
        zombieArray[shootedNumZ].zombieHitSavedTime = millis();
        zombieArray[shootedNumZ].shootStop = true; 
                
      }else if(zombieArray[shootedNumZ].shooted == true && canArray[shootedNumC].shooted == true){
      if(dist(zombieArray[shootedNumZ].x,zombieArray[shootedNumZ].y,hero.x,hero.y) < dist(canArray[shootedNumC].x,canArray[shootedNumC].y,hero.x,hero.y) || canArray[shootedNumC].x == width){
        zombieArray[shootedNumZ].hp -= gunArray[gunNow].power;
        hero.shooting = false;
        zombieArray[shootedNumZ].shooted = true; 
   
               
        //殭屍被打到的硬直
        zombieArray[shootedNumZ].zombieHitSavedTime = millis();
        zombieArray[shootedNumZ].shootStop = true; 
         
        
      }else{
        for (int i=0; i<zombieNow; i++) {
          if (isHit(zombieArray[i].x, zombieArray[i].y, zombieArray[i].img.width, zombieArray[i].img.height, canArray[shootedNumC].x-50, canArray[shootedNumC].y-50, canArray[shootedNumC].img.width+100, canArray[shootedNumC].img.height+100)) {
            dead =true;
        deadx = zombieArray[i].x;
        deady = zombieArray[i].y;
            zombieArray[i].x = width;
            zombieArray[i].y = height;
          }
        }
        println("123");
        fire =true;
        firex=canArray[shootedNumC].x;
        firey=canArray[shootedNumC].y;
        canArray[shootedNumC].x = width;
        canArray[shootedNumC].y = height;
        //---------------------sounds--------------------------//
        explosionSounds.trigger();
        //---------------------sounds--------------------------//
        hero.shooting = false;
        canArray[shootedNumC].shooted = false;
      }
      }
    }
    if(zombieArray[shootedNumZ] != null && canArray[shootedNumC] == null && zombieArray[shootedNumZ].shooted ==true){
      zombieArray[shootedNumZ].hp -= gunArray[gunNow].power;
      hero.shooting = false;
      zombieArray[shootedNumZ].shooted = true;   
      zombieArray[shootedNumZ].shooted = false;
      
      //殭屍被打到的硬直  
      zombieArray[shootedNumZ].zombieHitSavedTime = millis();
      zombieArray[shootedNumZ].shootStop = true; 
    }
  }
  
  if(gunNow == 3){ //0107 update shotGun 一次殺很多人
    hero.shooting = false;
  }

  //Block
  for (int i=0; i<blockMax; i++) {
    blockArray[i].display();
    blockArray[i].collision();
  }
  
      
    fill(255,255,255,150);
    rect(440,10,650,50);
    rect(630,630,650,700);
    fill(#2A2B55);
    
    textSize(32);
    text("Bullet: "+gunArray[gunNow].bulletNow+"/"+gunArray[gunNow].bulletMax, 675, 675);
    text("Gun:"+gunArray[gunNow].gunName, 675, 710);    
    text("Score "+score,450,50);
    if(score<1000){gunUL = " ";}
    textSize(20);
    text("UNLOCK"+" "+gunUL,800,45);
    if(score>=1000){uziUnlock = true; gunUL = "UZI";}
    if(score>=3000){shotgunUnlock = true; gunUL = "SHOTGUN";  if(gunArray[2]!=null){gunArray[2].shootRate = 30;}}
    if(score>=4000){barrelUnlock = true;gunUL = "BARREL";}
    if(score>=6000){rocketUnlock = true;gunUL = "ROCKET";}
    break;
    
    case GAME_CLEAR:
    switch(stageState){
      case 0:
      image(bg0,0,0);
      fill(0);
      break;
      case 1:
      image(bg1,0,0);
      fill(255);
      break;
    }
      textSize(90);
      text("stage clear !",150,250);
      textSize(50);
      text("press enter to next stage",100,500);
      if(keyCode == ENTER){
        gameState = GAME_RUN;
        changeStage();
      }
    break;
    
    case GAME_OVER:
    background(0);
    fill(255);
      textSize(90);
      text("you lose !",250,250);
      textSize(50);
      text("press enter to main menu",100,500);
      if(keyCode ==ENTER){
        gameState = GAME_START;
        
      }
    break;
    
    case GAME_WIN:
      image(bg2,0,0);
      textSize(90);
      text("you win !",300,250);
      textSize(50);
      text("press enter to main menu",100,500);
      stageState = 0;
    zombieNow = 0;
    score = 0;
    hero.hp = 100;
    gunNow = 1;
    gunArray[2] = null;
    gunArray[3] = null;
    gunArray[4] = null;
    gunArray[5] = null;
      if(keyCode == ENTER){
        gameState = GAME_START;
   
      }
    break;
    }

    
  
}

/*-----------------操控--------------------*/
void keyPressed() {
  switch(keyCode) {
  case UP : 
    isMovingUp = true ;
    hero.nowDirectionNum =Direction.UP;
    break ;
  case DOWN : 
    isMovingDown = true ;
    hero.nowDirectionNum =Direction.DOWN;
    break ;
  case LEFT : 
    isMovingLeft = true ; 
    hero.nowDirectionNum =Direction.LEFT;
    break ;
  case RIGHT : 
    isMovingRight = true ;
    hero.nowDirectionNum =Direction.RIGHT;
    break ;
  case ENTER : //暫時用來變換場景
    //changeStage();
    break;
  default :
    break ;
  }

  //槍枝變換 從1號開始 跟鍵盤按鍵、圖片編號一致
  int preGunNow = gunNow;
  if (key>='1' && key<='9') {
    gunNow = key-48;
    if (gunNow < gunLimit) {
      if (gunArray[gunNow] == null) {
        if(uziUnlock == true){
          gunArray[2] = new Gun(2);
        }else{gunNow = preGunNow;}
        if(shotgunUnlock == true){
          gunArray[3] = new Gun(3);
        }else{gunNow = preGunNow;}
        if(barrelUnlock == true){
          gunArray[4] = new Gun(4);
        }else{gunNow = preGunNow;}
        if(rocketUnlock == true){
          gunArray[5] = new Gun(5);
        }else{gunNow = preGunNow;}
        //gunArray[gunNow] = new Gun(gunNow);
      }
    }
  }
  //開槍
  if (key == ' ') {
    score+= 1000;  //for test
    if (gunArray[gunNow].bulletNow>0) {
      hero.shooting = true;
      if(gunTimer(gunArray[gunNow].shootRate, hero.shooting) == true){
        if(gunNow!=1){
          gunArray[gunNow].bulletNow --;
        }
        hero.shooting = true;
        hero.shooting(gunNow);
      }else{hero.shooting = false;}
      if(hero.shooting == true){
        gunArray[gunNow].gunSounds.trigger();
      }
    }
   if (gunNow==4) {
      if (gunArray[gunNow].bulletNow>0 ) {
        gunArray[gunNow].bulletNow --;
        if (canNow < canMax) {
          canArray[canNow] = new Can();
          canNow++;
          
        }
      }
  }
  if (gunNow==5) {
    setRocket=true;
    if (gunArray[gunNow].bulletNow>0 ) {
      gunArray[gunNow].bulletNow --;
      if (rocketNow < rocketMax) {   
        rocketArray[rocketNow] = new Rocket();
        rocketArray[rocketNow].d=hero.nowDirectionNum;
        rocketNow++;      
        //rocketSounds.trigger();
      }
    }
  }
  }
}

void keyReleased() {
  switch(keyCode) {
  case UP : 
    isMovingUp = false ;
    break ;
  case DOWN : 
    isMovingDown = false ; 
    break ;
  case LEFT : 
    isMovingLeft = false ; 
    break ;
  case RIGHT : 
    isMovingRight = false ; 
    break ;
  default :
    break ;
  }
  if (key == ' ') {
    hero.shooting = false;
  }
  if(key=='r'){
    setRocket=false;
  }
}

//---------------------計時器--每隔totalTime秒回傳一次true(單位毫秒)---//
boolean gunTimer(int totalTime, boolean startNow){  //startNow是指你要開始計時的時間點
  if(startNow ==true){
    gunPassedTime = millis()-gunSavedTime;
  }
  if(gunPassedTime>totalTime){
      gunSavedTime = millis();
      return true;
  }
  return false;
  
}

boolean treasureTimer(int totalTime, boolean startNow){  //startNow是指你要開始計時的時間點
  if(startNow ==true){
    treasurePassedTime = millis()-treasureSavedTime;
  }
  if(treasurePassedTime>totalTime){
      treasureSavedTime = millis();
      return true;
  }
  return false;
  
}
//---------------------計時器--------------------------//