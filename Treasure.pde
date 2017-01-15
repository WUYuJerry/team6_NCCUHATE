class Treasure{
int x,y;
int gunNum;
PImage img;
boolean textState = false;
int textFrameCount;
int addBulletNum;

Treasure(){
  switch(stageState){
   case 0:
     blockMax = 4;
     x = 150;
     y = 150;
     break;
   case 1:
     blockMax = 6;
     x = 1000;
     y = 250;
     break;
   case 2:
     blockMax = 7;
     x = 500;
     y = 150;
     break;
  }
  img = loadImage("img/treasure.png");
}

void display(){
  image(img,x,y);
}
boolean eaten(){
  if(isHit(hero.x,hero.y,hero.img.width,hero.img.height,x,y,img.width,img.height)){
    x = width;
    y = height;
    treasureSavedTime = millis();
    textFrameCount = frameCount;
    treasurePickUpSounds.trigger();
    addBullet();
    hero.hp += 50;
  }
  if(x == width && y == height){
    return true;
  }
  return false;
}
void addBullet(){
  int r = 0;
  while(gunArray[r]==null){r = floor(random(1,gunLimit));} //一直抽直到有槍
  addBulletNum =  r;
  if (gunArray[addBulletNum].bulletNow != gunArray[addBulletNum].bulletMax && gunArray[addBulletNum].bulletNow < gunArray[addBulletNum].bulletMax){
   gunArray[addBulletNum].bulletNow = gunArray[addBulletNum].bulletMax;
   hero.hp+=20;
   
  }
}
}