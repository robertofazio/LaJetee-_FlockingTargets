
class StopWatchTimer 
{
  int startTime = 0, stopTime = 0;
  boolean running = false; 
  void start() 
  {
    startTime = millis();
    running = true;
  }
  void stop() 
  {
    stopTime = millis();
    running = false;
  }
  int getElapsedTime() 
  {
    int elapsed;
    if (running) 
    {
      elapsed = (millis() - startTime);
    }
    else 
    {
      elapsed = (stopTime - startTime);
    }
    return elapsed;
  }
  int second() 
  {
    return (getElapsedTime() / 1000) % 60;
  }
  int minute() 
  {
    return (getElapsedTime() / (1000*60)) % 60;
  }
  int hour() 
  {
    return (getElapsedTime() / (1000*60*60)) % 24;
  }
}


String time() 
{
  String time = nf(sw.hour(), 2)+":"+nf(sw.minute(), 2)+":"+nf(sw.second(), 2);
  //println(time);
  return time;
}