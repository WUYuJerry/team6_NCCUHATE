public class Rocket{
int x;
int y;
int preX;
int preY;
int d;
int speed = 20;
PImage img;
  
Rocket(){
    x=hero.x;
    y=hero.y;
    img=loadImage("img/rocket2.png");  
  }
  
void display(){
    image(img,x,y,30,30);
}
void move(int d){
  if (d==Direction.UP) {
        y-= speed;
      }
      if (d==Direction.DOWN) {
        y+= speed;
      }
      if (d ==Direction.LEFT) {
        x-= speed;
      }
      if (d==Direction.RIGHT) {
        x+= speed;
      }

}
}