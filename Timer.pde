class Timer {

  private int startMills ; 

  private int accumulation ; 

  private boolean active = false ; 

  void start() {
    active = true ;
    startMills = millis() ;
  }

  void stop () {
    active = false ;
    startMills = -1 ;
    accumulation = 0 ;
  }

  void pause () {
    if (active) {
      accumulation = accumulation + millis() - startMills  ;
    }
    active = false ;
  }

  float duration () { // seconds
    return  (active ? accumulation + millis() - startMills : accumulation ) /1000.0 ;
  }
  
  boolean isActive() {
    return active ;
  }
}

class CountDownTimer extends Timer {

  float totalTime ; 
  CountDownTimer (float seconds ) {
    setTime (seconds);
  }
  void addTime (float seconds) {
    totalTime += seconds * 1000 ;
  }
  void setTime (float seconds) {
    totalTime =  seconds * 1000 ; // milliseconds
  }
  float remaining() {
    return totalTime/1000.0 - duration();
  }

  boolean isEnded () {
    return remaining() <= 0 ;
  }
}



class IntervalTimer extends Timer {

  float interval ;
  IntervalTimer (float seconds) {
    interval = seconds ;
  }

  int times = 0 ;
  boolean arrived () {
    if (times == floor( duration() / interval )) {
      return false ;
    } else {  
      times = floor( duration() / interval ) ;
      return true ;
    }
  }
}