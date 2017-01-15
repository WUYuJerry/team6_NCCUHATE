class Weapon{
float power;
float shootRate;
int num;
int distance;
PImage canimg;//汽油桶
float x;
float y;
Weapon(){
 canimg=loadImage("img/can.png");
 x=random(float(560));
 y=random(float(410));
}

void display(){
 image(canimg,x,y);
}

void move(){

}


}