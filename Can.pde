public class Can{
int x;
int y;
int preX;
int preY;
PImage img;
boolean shooted;
  
Can(){
    x=hero.x;
    y=hero.y;
    img=loadImage("img/oil.png");  
  }
  
void display(){
    image(img,x,y);
}
//can與主角的槍偵測
boolean shooted(int heroDirection, int canNum, int gunNum,int gunFourDectection){
  switch(heroDirection){
    case Direction.UP:
     if(canArray[canNum].x+canArray[canNum].img.width > hero.x+30 -gunFourDectection && hero.x+30+gunFourDectection >canArray[canNum].x){
       if(canArray[canNum].y+canArray[canNum].img.height > hero.y-20-gunArray[gunNum].distance && hero.y-20>canArray[canNum].y){
         return true;
       }
     }
    break;
    case Direction.DOWN:
    if(canArray[canNum].x+canArray[canNum].img.width > hero.x+5 -gunFourDectection&& hero.x+5 +gunFourDectection> canArray[canNum].x){
      if(canArray[canNum].y < hero.y+hero.img.height+20+gunArray[gunNum].distance&&hero.y+hero.img.height+20<canArray[canNum].y+canArray[canNum].img.height){
        return true;
      }
    }
    break;
    case Direction.LEFT:
    if(canArray[canNum].y+canArray[canNum].img.height > hero.y+10-gunFourDectection && hero.y+10+gunFourDectection > canArray[canNum].y){
      if(canArray[canNum].x+canArray[canNum].img.width > hero.x-20-gunArray[gunNum].distance && hero.x-20>canArray[canNum].x){
        return true;
      }
    }
    break;
    case Direction.RIGHT:
    if(canArray[canNum].y+canArray[canNum].img.height > hero.y+25-gunFourDectection && hero.y+25+gunFourDectection > canArray[canNum].y){
      if(canArray[canNum].x < hero.x+hero.img.width+20+gunArray[gunNum].distance&& hero.x+hero.img.width+20 <canArray[canNum].x+canArray[canNum].img.width){
        return true;
      }
    }
    break;
  }
  return false;
} 



}