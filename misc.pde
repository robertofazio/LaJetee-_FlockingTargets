class Rectangle
{
  Rectangle(float _x, float _y, float _w, float _h){set( _x, _y, _w, _h);
  }

  void set(float _x, float _y, float _w, float _h)
  {
    x=_x;
    y=_y;
    w=_w;
    h=_h;
  }
  
  PVector getCenter()
  {
    return new PVector(x+(w/2),y+(h/2));
  }
  
  PVector randomPointInside()
  {
    return new PVector(random(x,x+w),random(y,y+h));
  }
  
  boolean isInside(PVector p)
  {
    return (p.x>x&&p.x<(x+w)&&p.y>y&&p.y<(y+h));
  }
  
  float x;
  float y;
  float w;
  float h;
}

class PtrBool{
  PtrBool(){
    b = false;
  }
  boolean b;
}

//Creo un puntatore per il target che dovranno seguire i boid
class ptrMyTarget{
    ptrMyTarget(){
      myTgt = new PVector(width/2,height/2);
    }
 PVector myTgt;
}