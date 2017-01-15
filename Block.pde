class Block{

float x,y;
PImage img;

Block(int state, int num, float x, float y){
  this.x = x;
  this.y = y;
  img = loadImage("img/block"+state+"_"+num+".png");
}

void display(){
  image(img,x,y);
}
void collision(){
  int direction = isHitDirection(hero.x,hero.y,hero.img.width,hero.img.height,x,y,img.width,img.height,0);
    switch(direction){
    case Direction.LEFT:
     hero.x += hero.speed;
     break;
    case Direction.RIGHT:
     hero.x -= hero.speed;
     break;    
    case Direction.UP:
     hero.y += hero.speed;
     break;
    case Direction.DOWN:
     hero.y -= hero.speed;
     break;
  }
  
}

}