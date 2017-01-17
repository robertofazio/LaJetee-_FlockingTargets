public class MovCam 
{
  boolean isMoving;
  float speedx, speedy, speedz;
  float cnt_x;
  float cnt_y;
  float cnt_z;
  float rot;

  MovCam ()
  {
    isMoving = false;
  }

  void updateSpeed(boolean start, float _speed_X, float _speed_Y, float _speed_Z, float _rotate)
  {
    isMoving = start;
    speedx = _speed_X;
    speedy = _speed_Y;
    speedz = _speed_Z;
    rot = _rotate;

    if(isMoving)
    {
      cnt_x += speedx;
      cnt_y += speedy;
      cnt_z += speedz;
    }
      
    if (!isMoving)
    {
      speedx -= cnt_x;
      speedy -= cnt_y;
      speedz -= cnt_z;
    
     // isMoving = true;
      println(isMoving);
    } 

    translate(cnt_x, cnt_y, cnt_z);
    //rotate(radians(rot));
    //println("isMoving: "+ isMoving + " speedX: " + cnt_x + " speedY: " + cnt_y + " speedZ: " + cnt_z, " rotate: " + rot);

  }

void reset()
{
  cnt_x += (cnt_x * -1);
  cnt_y += (cnt_y * -1);
  cnt_z += (cnt_z * -1);
  isMoving = false;
  
}

}



