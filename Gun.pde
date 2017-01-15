class Gun { //<>// //<>//
  int num; //槍枝編號
  float power;
  int shootRate;
  int distance;
  int bulletMax;
  int bulletNow;
  int range;
  PImage img;
  AudioSample gunSounds;
  String gunName;
  Gun(int num) {
    if (num!=3) {
    }
    this.num = num;
    switch(num) {
    case 1: //pistol
      power = 25;
      shootRate = 500;
      distance = 500;
      bulletMax = 100;
      bulletNow = 100;
      range =0;
      this.gunSounds = pistolGunSounds;
            gunName = "PISTOL";

      break;
    case 2:  //uzi
      power = 50;
      shootRate = 100;
      distance = 500;
      bulletMax = 100;
      bulletNow = 100;
      range =0;
      this.gunSounds = uziGunSounds;
      gunName = "UZI"; 
    
      break;
    
    case 4:
        distance = 0;
        bulletMax  = 200;
        bulletNow  = 200;
        this.gunSounds = canPlaceSounds;
                gunName = "BARREL";

      break;
     case 3:  //shotgun
      power = 100;
      shootRate = 1200;
      distance = 300;
      bulletMax = 2000;
      bulletNow = 2000;
      range = 30 ;
            gunName = "SHOTGUN";
      this.gunSounds = shotGunSounds;
      break;
     case 5:
      power = 10;
      shootRate = 2;
      bulletMax = 50;
      bulletNow = 50;
            gunName = "ROCKET";
      this.gunSounds = rocketSounds;
      break;     
    }
  }

  void display() { 
    
  }  //<>//
}