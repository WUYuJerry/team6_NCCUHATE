boolean blocked = false;
boolean LBlocked = false;
boolean RBlocked = false;
boolean UBlocked = false;
boolean DBlocked = false;
int U=0;
int D=1;
int L=2;
int R=3;


boolean isHit(float ax, float ay, float aw, float ah, float bx, float by, float bw, float bh) {
  if (ax >= bx - aw && ax <= bx + bw && ay >= by - ah && ay <= by + bh) {
    return true;
  }
  return false;
}

int isHitDirection(float ax, float ay, float aw, float ah, float bx, float by, float bw, float bh, int range) { //上下左右位置必須調換 update range
  if (ax >= bx - aw && ax + aw + range <= bx + 5 && ay + ah +range >= by  && ay - range <= by + bh) {  //a 的右邊撞到 b  //0104 update
    println("touchright: "+ (ax+aw) +" "+ bx +" "+ (ay+ah) +" "+ by);
    return Direction.RIGHT;
  }
  if (ax-range <= bx + bw && ax >= bx + bw -5 && ay + ah + range >= by  && ay - range <= by + bh) {  //a 的左邊撞到 b  //0104 update

    return Direction.LEFT;
  }
  if (ax -range >= bx - aw && ax+range <= bx + bw && ay +range >= by - ah && ay + ah <= by + 5) {  //a 的下面撞到 b  //0104 update
    println("touchdown: "+ ax +" "+ (bx+bw) +" "+ (ay+ah) +" "+ by);
    return Direction.DOWN;
  }
  if (ax-range >= bx - aw && ax+range <= bx + bw && ay-range <= by + bh && ay >= by + 5) {  //a 的上面撞到 b  //0104 update
    //println("touchup");
    return Direction.UP;
  }
  return 4;
}

void changeStage(){
  stageState++;
  switch(stageState){
  case 0:
     blockMax = 4;
     treasure.x = 150;
     treasure.y = 150;
     zombieWave = 1;
      bgSounds = washerbgSounds;
     break;
   case 1:
   bgSounds.pause();
     blockMax = 6;
     zombieWave = 4;
     treasure.x = 1000;
     treasure.y = 250;
     break;
   case 2:
     blockMax = 7;
     zombieWave = 7;
     treasure.x = 500;
     treasure.y = 150;
      bgSounds = kitchenbgSounds;
     bgSounds.play();
     break;
  }
  int bX[] = new int[blockMax]; //每個block的x
  int bY[] = new int[blockMax];
  json = loadJSONObject("json_block/data/block"+stageState+".json");
  JSONArray values = json.getJSONArray("block");
  for(int i=0; i<values.size(); i++){
    JSONObject block = values.getJSONObject(i); 
    bX[i] = block.getInt("x");
    bY[i] = block.getInt("y");
  }
  for(int i=0; i<blockMax; i++){
    blockArray[i] = new Block(stageState, i, bX[i], bY[i]);
  }
}