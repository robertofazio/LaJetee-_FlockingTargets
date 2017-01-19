// last update 19.01.2017 - Roberto Fazio Studio

import processing.sound.*;

SoundFile file;
Flock flock;
PImage[] bgImage;
PImage selected;
boolean showvalues = true;
boolean scrollbar = false;
int totBoids = 0;
int numParts = 900;
//CREO IL MIO PUNTATORE "GLOBALE" AL TARGET DI MOVIMENTO
ptrMyTarget myTargetPtr;
//SETTO UNA VARIABILE CHE REGOLA LA VELOCITA' DI MOVIMENTO DEL MIO TARGET
float targetSpeed;
//SETTO UNA VARIABILE TEMPO IN SECONDO
float second;
PFont font;
PtrBool goToTarget;
float timer1,timer2,timer3,timer4;
int selector = 0;
int cntFadeText = 0;
float aFade = 0;
boolean bFade = false;
//MACCHINA A STATI
enum boidStateMachine
{
  firstText,
  oneBoid,
  twoBoid,
  threeBoid,
  enterBoid,
  reset,
  boidSwarming,
  attractor,
  text,
  exitBoid
}

boidStateMachine boidState;
//Dichiaro una variabile timer globale
float timerMachineState=0;

float pctText1,pctText2,pctText3;
String coloumnTextTitle,coloumnTextParagraph,firstTitle;
float rSz;
StopWatchTimer sw;

void setup()
{
  sw = new StopWatchTimer();
  sw.start();

  frameRate(60);
  size(1280, 720, P3D);
  goToTarget = new PtrBool();
  setupScrollbars();
  flock = new Flock();

  //INSTANZIO IL MIO TARGET
  myTargetPtr = new ptrMyTarget();
  //SETTO LA MIA VARIABILE DI VELOCITA'
  targetSpeed = 1.0/3.0;
  setBoidSwarming();
  smooth(8);
  
  boidState = boidStateMachine.firstText;
  timerMachineState = 0;
 
  timer1 = 0.0;
  timer2 = 0.0;
  timer3 = 0.0;
  timer4 = 0.0;
  
  font = createFont("Edmondsans-Regular", 32);
  
  bgImage = new PImage[6];
  bgImage[0] = loadImage("img/bn/italy.jpg");
  bgImage[1] = loadImage("img/bn/emilia.jpg");
  bgImage[2] = loadImage("img/bn/lazio.jpg");
  bgImage[3] = loadImage("img/bn/liguria.jpg");
  bgImage[4] = loadImage("img/bn/puglia.jpg");
  bgImage[5] = loadImage("img/bn/sardegna.jpg");
  selected = bgImage[0];

  file = new SoundFile(this,"audio/1.mp3");
  file.play();

  movCam = new MovCam();
  _isMoving = true;
  _speedx = -0.1f;
  _speedy = -0.1f;

  coloumnTextParagraph = "";
  firstTitle = "";
  coloumnTextTitle = "";


}
//RIASSUMO IL SETTING INIZIALE IN UNA FUNZIONE RICHIAMABILE NELLA STATEMACHINE
void setBoidSwarming()
{
    goToTarget = new PtrBool();
    //String lines[] = loadStrings("scena_01.txt");
    timerMachineState = millis();
    //firstTitle = lines[0];
    //coloumnTextTitle = lines[1];
    //coloumnTextParagraph = lines[2];
    // pctText1 = int(lines[3]);
    // pctText2 = int(lines[4]);
    // pctText3 = int(lines[5]);
    //firstTitle = "";
    //coloumnTextTitle = "";
    
    //pctText1 = 54;
    //pctText2 = 30;
    //pctText3 = 16;
    
    makeBoids(numParts, new Rectangle(0,0,width,height), false);
    //makeRectTarget(new Rectangle(width/2-100,height/2-100,200,200), 20, 25);
    
    //questa fa rettangoli di uguale densita' ma riempiti solo fino alla pct
    makePctsFilledRects((int)pctText1,(int)pctText2,(int)pctText3);
    
    //questa fa rettangoli di uguali dimensioni e sparge particles a caso all'interno
    //makePctsDensity(60,30,10);
  
}
void makeBoids(int n, Rectangle r, boolean addThem)
{
  if(addThem)
  {
    totBoids+=n;
  }
  else
  {
    flock.boids.clear();
    totBoids = n;
  }
  for(int i=0; i<n; i++)
  {
    //PVector p = r.randomPointInside();
    PVector p;
    if(i<6)
      p = new PVector(random(-50.0,0),random(height/2 - 200, height/2 + 200));
    else
      p = new PVector(random(-width+width/2,0),random(0,height));
    //PASSO IL MIO PUNTATORE AI BOIDS COSICCHE' NE POSSANO FARE UNA "COPIA"
    flock.addBoid(new Boid(p.x,p.y, goToTarget,myTargetPtr));
  }
}

int [] getPartsPerPct(int pct1, int pct2, int pct3)
{
  int [] pcts = new int[3];
  pcts[0] = int(numParts*(float(pct1)/100.0));
  pcts[1] = int(numParts*(float(pct2)/100.0));
  pcts[2] = numParts-pcts[1]-pcts[0];
  return pcts;
}

void makePctsDensity(int pct1, int pct2, int pct3)
{
  //questa ti fa rettangoli uguali, riempiti a densita differente
  
  int [] pcts = getPartsPerPct(pct1,pct2,pct3);
  
  rSz = 300;
  Rectangle [] rects = new Rectangle[3];
  
  rects[0] = new Rectangle(width/6-rSz/2, height/2-rSz/2, rSz,rSz);
  rects[1] = new Rectangle(width/2-rSz/2, height/2-rSz/2, rSz,rSz);
  rects[2] = new Rectangle(width*5/6-rSz/2, height/2-rSz/2, rSz,rSz);
  
  int curBoid = 0;
  for(int i=0;i<3;i++)
  {
    int start = curBoid;
    int stop = curBoid+pcts[i];
    if(stop>numParts)stop=numParts-1;
  
    for(int j=start;j<stop;j++)
    {
      PVector tgt = rects[i].randomPointInside();
      Boid b = flock.boids.get(j);
      b.tgt = tgt;
    }
    curBoid = stop;
    
  }
}

void makePctsFilledRects(int pct1, int pct2, int pct3)
{
  // questa prepara 3 rettangoli delle stesse dimensioni e con la stessa densita'
  // le particles li riempiono parzialmente, secondo pct
  
  int [] pcts = getPartsPerPct(pct1,pct2,pct3);
  
  int ppw;
  int pph=1;
  float pps = sqrt(numParts);
  
  if((pps-int(pps)==0)){
    ppw=int(pps);
    pph=int(pps);
  }else{
    Boolean b=true;
    ppw=int(pps);
    while(b){
      if((numParts%ppw)==0){
        b=false;
      }else{
        ppw--;
        pph = numParts/ppw;
      }
    }
  }
  
  rSz = 300;
  // rects position
  Rectangle r1 = new Rectangle(width*1/8-rSz/2 + 150,height/2-rSz/2,rSz,rSz);
  Rectangle r2 = new Rectangle(width*3/8-rSz/2 + 150,height/2-rSz/2,rSz,rSz);
  Rectangle r3 = new Rectangle(width*5/8-rSz/2 + 150,height/2-rSz/2,rSz,rSz);
  
  int start = 0; int stop = start+pcts[0];
  makeRectTarget(r1,ppw,pph,start,stop);
  start = stop+1; stop = start+pcts[1];
  makeRectTarget(r2,ppw,pph,start,stop);
  start = stop+1; stop = numParts-1;
  makeRectTarget(r3,ppw,pph,start,stop);
}

void makeRectTarget(Rectangle r, int nRows, int nCols)
{
  makeRectTarget(r,nRows,nCols,0,numParts-1);
}

void makeRectTarget(Rectangle r, int nRows, int nCols, int boidStart, int boidStop){
  
  float yInc = r.h/nCols;
  float xInc = r.w/nRows;
  int bIdx = boidStart;
  for(float y=r.y;y<(r.y+r.h);y+=yInc){
    for(float x=r.x;x<(r.x+r.w);x+=xInc){
      PVector tgt = new PVector(x,y);
      Boid b = flock.boids.get(bIdx);
      b.tgt = tgt;
      bIdx++;
      if(bIdx>boidStop)return;
    }
  }
}

void draw()
{
  fill(0);
  background(255);

  time();
  

  pushMatrix();
  tint(255,255); 
  movCam.updateSpeed(_isMoving, _speedx, _speedy, _speedz, _rotate);
  image(selected,0,0);
  popMatrix();
  
  finale(bFinale);
  
  pushMatrix();
  showOverlay(overlay);
  popMatrix();

  scena(actualScene);
  showOverlayFirstScene(bOverlayFirstScene);

  if(bFade)
      cntFadeText++;
  //println(cntFadeText);
  switch(boidState)
  {
    case firstText:
      pushStyle();

      fill(0,0,0);
      textFont(font, 44);

      textAlign(CENTER,CENTER);
      
      text(firstTitle, 0, 0,width, height); 
      popStyle();

      if(millis() - timerMachineState>=5000)
        boidState = boidStateMachine.oneBoid;
      break;
    case oneBoid:
      if(millis()-timerMachineState >= timer1)
      {
       timerMachineState = millis();
       boidState = boidStateMachine.twoBoid;

      }
      flock.runWithLimit(1);
      break;
    case twoBoid:
      if(millis()-timerMachineState >= timer2)
      {
       timerMachineState = millis();
       boidState = boidStateMachine.threeBoid;

      }
      flock.runWithLimit(3);
      break;
    case threeBoid:
      if(millis()-timerMachineState >= timer3)
      {

       timerMachineState = millis();
       boidState = boidStateMachine.enterBoid;
      }
      flock.runWithLimit(6);
      break;
    case enterBoid:
    if(millis()-timerMachineState<= timer4)
    {
        myTargetPtr.myTgt.y -= 0.8;
    }
    else
    {
      timerMachineState = millis();
      boidState = boidStateMachine.boidSwarming;
    }
      flock.runWithLimit(flock.boids.size());
      break;
    case boidSwarming:

      Swarming();
      setScrollbarVel(0.5);
      break;
    case attractor:
      Swarming();
      goToTarget.b = true;
      if(millis()-timerMachineState >= 4000)
      {
        timerMachineState = millis();
        boidState = boidStateMachine.text;
      }
      break;
    case text:
      Swarming();
      pushStyle();

      bFade = true;      
      if(cntFadeText == 255)
      {
        cntFadeText = 255;
        bFade = false;
      }
    
      fill(0,0,0,cntFadeText);

      textFont(font, 32);
      textAlign(LEFT);
      float heightMax = max( height/2 + rSz*4/6 - rSz*(100-pctText1)/100 , height/2 + rSz*4/6 - rSz*(100-pctText2)/100);
      heightMax= max(heightMax,height/2 + rSz*4/6 - rSz*(100-pctText3)/100);
      text(str(pctText1) + "%", width/8 -rSz/2 + 150, heightMax, rSz,100); 
      text(str(pctText2) + "%", width*3/8 -rSz/2 + 150,heightMax, rSz,100); 
      text(str(pctText3) + "%", width*5/8 -rSz/2 + 150,heightMax , rSz,100); 

      textFont(font, 16);
      //textAlign(LEFT);
      textLeading(14);
      float textGapFromPct = 18;
      text("\n"+primaDesrizione,width/8 -rSz/2 + 150, heightMax+textGapFromPct, rSz,100);
      text("\n"+secondaDescrizione,width*3/8 -rSz/2 + 150,heightMax+textGapFromPct, rSz,100); 
      text("\n"+terzaDescrizione,width*5/8 -rSz/2 + 150,heightMax+textGapFromPct , rSz,100); 
      
      textAlign(CENTER);
      textFont(font, 64);
      textLeading(58);
      text(coloumnTextTitle, width - 300, 150, 300, 600);
      textFont(font, 24);

      //Interspazio testo TITOLI scena TARGET BOIDS
      textLeading(26);
      text(coloumnTextParagraph, width/2, 100); 
      popStyle();
      break;

    case reset:
        myTargetPtr = new ptrMyTarget();
        setBoidSwarming();  
        setScrollbarVel(0.5);
        timerMachineState = millis();

        boidState = boidStateMachine.firstText;

        // fade out text
        cntFadeText = 0;

      break;
    case exitBoid:
          if(goToTarget.b == true)
            goToTarget.b = false;
          flocking();
      break;
    default:
      break;
  }

  drawScrollbars();
  if(showvalues){
    pushStyle();
    fill(0);
    textAlign(LEFT);
    //text("FPS: "+round(frameRate),5,100);
    popStyle();
  }
  

  //SE VUOI VEDERE DISEGNATO IL TARGET SCOMMENTA LA LINEA DI SOTTO
  //  ellipse(myTargetPtr.myTgt.x,myTargetPtr.myTgt.y,10,10);

  // SAVEFRAMES
  //saveFrame("/Volumes/RF500_2016/frames/####.png");
 
}

//SWARMING
void Swarming()
{
  flocking();
  //MI CALCOLO IL TEMPO IN SECONDI PER POTER CALCOLARE IL SIN E IL COS
  second = (millis() - timerMachineState)/ 1000.0;
  //SETTO LA POSIZIONE AL MIO PUNTATORE RICREANDO UN MOVIMENTO OSCILLATORIO ANDATA-RITORNO
  myTargetPtr.myTgt = new PVector((width-100)/2 + sin(second * targetSpeed )*(width-200)/2,  cos(second * targetSpeed) * -sin(second * targetSpeed)*(height-300) + (height-150)/2);
  
}

void flocking()
{
  flock.run();
}

void keyPressed()
{
  if(key == '0')
  {
    // println("reset"); 
    // actualScene = 0;
    // boidState = boidStateMachine.reset;
    //bScene = true;
  }
    
}