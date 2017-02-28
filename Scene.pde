
boolean overlay = false;
float cnt = 0;
float _cnt = 0;
boolean first = false;
MovCam movCam;
boolean _isMoving = false;
float _speedx, _speedy, _speedz;
float _rotate;
float counterState = 0;
int actualScene = 0;
int cntScene = 0;
boolean bScene = false;

String tScena00 = "0";  // INTRODUZIONE 
String tScena01 = "1234";  // IN DATA VIZ
String tScena01a = "2118"; // EXIT 

String tScena02 = "2662";  // PLASTICITA'
String tScena02a = "4218"; // IN DATA VIZ
String tScena03 = "5470";  // EXIT

String tScena03a = "5987"; // COMPORTAMENTO EMERGENTE 
String tScena04 = "7178";  // IN DATA VIZ 
String tScena04a = "8246"; // EXIT

String tScena05 = "8764";  // EQUILIBRIO PUNTEGGIATO
String tScena05a = "9937"; // IN DATA VIZ
String tScena06 = "11305";  // EXIT 

String tScena06a = "11657"; // CONNETIVITA'
String tScena07 = "12805";  // IN DATA VIZA
String tScena07a = "14363"; // EXIT

String tScena08 = "14721";  // EVENTO CAPITALE 
String tScena08a = "16040"; // IN DATA VIZ
String tScena09 = "17059";  // EXIT 

String tScena10 = "18000";  // FINALE

// String tScena00 = "00:00:00";  // INTRODUZIONE 
// String tScena01 = "00:00:35";  // IN DATA VIZ
// String tScena01a = "00:01:00"; // EXIT 

// String tScena02 = "00:01:15";  // PLASTICITA'
// String tScena02a = "00:01:55"; // IN DATA VIZ
// String tScena03 = "00:02:30";  // EXIT

// String tScena03a = "00:02:45"; // COMPORTAMENTO EMERGENTE 
// String tScena04 = "00:03:15";  // IN DATA VIZ 
// String tScena04a = "00:03:45"; // EXIT

// String tScena05 = "00:04:00";  // EQUILIBRIO PUNTEGGIATO
// String tScena05a = "00:04:30"; // IN DATA VIZ
// String tScena06 = "00:05:10";  // EXIT 

// String tScena06a = "00:05:20"; // CONNETIVITA'
// String tScena07 = "00:05:50";  // IN DATA VIZA
// String tScena07a = "00:06:35"; // EXIT

// String tScena08 = "00:06:45";  // EVENTO CAPITALE 
// String tScena08a = "00:07:20"; // IN DATA VIZ
// String tScena09 = "00:07:50";  // EXIT 

// String tScena10 = "00:08:02";  // FINALE

float timer = 0;
// first scene setting
boolean bOverlayFirstScene = false;
float cntFirstScene  = 0;
boolean bFirst = false;
//descrizione testi percentuali
String primaDesrizione = "";
String secondaDescrizione = "";
String terzaDescrizione = "";
String title = "";
String v1 = "";
String v2 = "";
String v3 = "";
String d1 = "";
String d2 = "";
String d3 = "";
float size1,size2,size3;
boolean bOverlayOtherScene = false;
int hFont = 22;
int scena(int _actualScene)
{
  //println(cntScene);
  actualScene = _actualScene;
  if(!bScene)
  {
    switch (actualScene) 
    {
      case 0:
      println("tScena00 : " + time() + " " + cntScene);
      pushMatrix();
      movCam.reset();
      _isMoving = true;
      _speedx = -0.07f;
      _speedy = -0.05f;
      selected = bgImage[0];
      popMatrix();
      file.stop();
      file = new SoundFile(this,"audio/1.mp3");
      file.play();

      //voce.stop();
      //voce = new SoundFile(this, "audio/v1.mp3");
      //voce.play();

      coloumnTextParagraph = "";
      firstTitle = ""; // INTRODUZIONE
      boidState = boidStateMachine.reset;
      bScene = true;
      break;

      case 1:
      println("tScena01 : " + time() + " " + cntScene);
      bOverlayFirstScene = true;
      bScene = true;
      break;

      case 2:
      println("tScena01a : " + time() + " " + cntScene);
      bOverlayFirstScene = false;
      myTargetPtr.myTgt = new PVector(width+width/2,height/2);
      boidState = boidStateMachine.exitBoid;
      bScene = true;
      break;
         
      case 3:
      println("tScena02 : " + time() + " " + cntScene);
      
      bSaveToDisk = true;
      
      overlay = false;
      pushMatrix();
      movCam.reset();
      _isMoving = true;
      _speedx = -0.05f;
      _speedy = -0.05f;
      //_rotate = 20.0f;
      selected = bgImage[1];
      popMatrix();
      file.stop();
      file = new SoundFile(this,"audio/2.mp3");
      file.play();
      // voce.stop();
      // voce = new SoundFile(this, "audio/v2.mp3");
      // voce.play();
      coloumnTextTitle = "";
      firstTitle = "PLASTICITÀ";
      pushStyle();
      textLeading(30);
      coloumnTextParagraph = "Cosa vanno a cercare i DS nelle reti?\n64,5% è alla ricerca di formazione e autoformazione.";
      popStyle();
      pctText1 = 54; // 54% dei membri sono docenti
      pctText2 = 30; // 30% dei membri sono Direttori amministrativi 
      pctText3 = 16; // 16% dei membri sono divisi fra personale ATA, ricercatori e famiglie.

      primaDesrizione = "dei membri delle reti sono docenti.";
      secondaDescrizione = "dei membri delle reti sono Direttori amministrativi.";
      terzaDescrizione = "dei membri delle reti sono divisi fra personale ATA, ricercatori e famiglie.";
      boidState = boidStateMachine.reset;
      bScene = true;
      break;

      case 4:
      println("tScena02a : " + time() + " " + cntScene);
     
      overlay = true;
      if(!goToTarget.b)
      {
        boidState = boidStateMachine.attractor;
      }
      else if(goToTarget.b && boidState == boidStateMachine.text)
      {
        myTargetPtr.myTgt = new PVector(width+width/2,height/2);
        boidState = boidStateMachine.exitBoid;
      }
      //timerMachineState = millis();
      bScene = true;
      break; 

      case 5:
      println("tScena03 : " + time() + " " + cntScene);
        
      overlay = false;
      if(!goToTarget.b)
      {
        boidState = boidStateMachine.attractor;
      }
      else if(goToTarget.b && boidState == boidStateMachine.text)
      {
        myTargetPtr.myTgt = new PVector(width+width/2,height/2);
        boidState = boidStateMachine.exitBoid;
      }
      bScene = true;
      break; 
        
      case 6:
      println("tScena03a : " + time() + " " + cntScene);
      bSaveToDisk = false;
      pushMatrix();
      movCam.reset();
      _speedx = -0.04f;
      _speedy = -0.05f;
      selected = bgImage[2];
      popMatrix();
      file.stop();
      file = new SoundFile(this,"audio/3.mp3");
      file.play();
      // voce.stop();
      // voce = new SoundFile(this, "audio/v3.mp3");
      // voce.play();
      coloumnTextTitle = "";
      firstTitle = "COMPORTAMENTO EMERGENTE";
      boidState = boidStateMachine.reset;
      bScene = true;
      break;

      case 7:
      println("tScena04 : " + time() + " " + cntScene);
      bOverlayFirstScene = true;
      bOverlayOtherScene = true;
      bScene = true;
      break;

      case 8:
      println("tScena04a : " + time() + " " + cntScene);
      bOverlayOtherScene = false;
      bOverlayFirstScene = false;
      myTargetPtr.myTgt = new PVector(width+width/2,height/2);
      boidState = boidStateMachine.exitBoid;
      bScene = true;
      break;

      case 9:
            

      println("tScena05 : " + time() + " " + cntScene);
      pushMatrix();
      movCam.reset();
      _speedx = -0.06f;
      _speedy = 0.0f;
      selected = bgImage[3];
      popMatrix();
      file.stop();
      file = new SoundFile(this,"audio/4.mp3");
      file.play();
      // voce.stop();
      // voce = new SoundFile(this, "audio/v4.mp3");
      // voce.play();
      coloumnTextTitle = "";
      firstTitle = "EQUILIBRIO PUNTEGGIATO";
      coloumnTextParagraph = "Secondo i DS, quale aspetto della propria rete può essere migliorato?\n"+
                             "Il 44,1% dei Ds avverte la necessità di consolidare la propria rete.";
      
      pctText1 = 42.4f; //42,4%
      pctText2 = 38.6f; // 38,6%
      pctText3 = 3.2f; //3,2%
      primaDesrizione = "delle reti è nello stadio di crescita e di sviluppo.";
      secondaDescrizione = "delle reti è nello stadio di maturità.";
      terzaDescrizione = "delle reti è nella fase di declino.";

      boidState = boidStateMachine.reset;
      bScene = true;
      break;

      case 10:
      println("tScena05a : " + time() + " " + cntScene);
      overlay = true;
      if(!goToTarget.b)
      {
        boidState = boidStateMachine.attractor;
      }
      else if(goToTarget.b && boidState == boidStateMachine.text)
      {
        myTargetPtr.myTgt = new PVector(width+width/2,height/2);
        boidState = boidStateMachine.exitBoid;
      }
      bScene = true;
      break;

      case 11:

      println("tScena06 : " + time() + " " + cntScene);
      
      
      overlay = false;
      if(!goToTarget.b)
      {
        boidState = boidStateMachine.attractor;
      }
      else if(goToTarget.b && boidState == boidStateMachine.text)
      {
        myTargetPtr.myTgt = new PVector(width+width/2,height/2);
        boidState = boidStateMachine.exitBoid;
      }
      bScene = true;
      break;

      case 12:
      

      println("tScena06a " + time() + " " + cntScene);
      pushMatrix();
      movCam.reset();
      _speedx = -0.05f;
      _speedy = -0.05f;
      selected = bgImage[4];
      popMatrix();
      file.stop();
      file = new SoundFile(this,"audio/5.mp3");
      file.play();
      // voce.stop();
      // voce = new SoundFile(this, "audio/v5.mp3");
      // voce.play();
      firstTitle = "CONNETIVITÀ";
      coloumnTextParagraph = "Il concetto di connettività si applica senza distinzione sia alle reti on line che off line. Il 70% delle\n"+
                              "reti/comunità professionali nasce sul territorio. Il 25% delle reti territoriali nate sul territorio\n"+
                              "si estendono oltre i confini locali, sul web. Questo dato viene confermato anche dall’Indagine Dsinrete\n"+
                              "riguardo al livello di partecipazione, ma solo se incrociamo due risposte.";
      pctText1 = 70f;
      pctText2 = 22f;
      pctText3 = 8f;
      primaDesrizione = "la partecipazione alla rete è per il 68,4% in presenza.";
      secondaDescrizione = "e per il 22,75% online.";
      terzaDescrizione = "8.85% Altro.";
      boidState = boidStateMachine.reset;
      bScene = true; 
      break;


      case 13:
      println("tScena07 : " + time() + " " + cntScene);
      overlay = true;
      if(!goToTarget.b)
      {
        boidState = boidStateMachine.attractor;
      }
      else if(goToTarget.b && boidState == boidStateMachine.text)
      {
        myTargetPtr.myTgt = new PVector(width+width/2,height/2);
        boidState = boidStateMachine.exitBoid;
      }
      bScene = true;
      break;


      case 14:
      println("tScena07a : " + time() + " " + cntScene);
      overlay = false;
      if(!goToTarget.b)
      {
        boidState = boidStateMachine.attractor;
      }
      else if(goToTarget.b && boidState == boidStateMachine.text)
      {
        myTargetPtr.myTgt = new PVector(width+width/2,height/2);
        boidState = boidStateMachine.exitBoid;
      }
      bScene = true;
      break;

      case 15:
      
      println("tScena08 : " + time() + " " + cntScene);
      pushMatrix();
      movCam.reset();
      _speedx = -0.06f;
      _speedy = -0.06f;
      selected = bgImage[5];
      popMatrix();
      file.stop();
      file = new SoundFile(this,"audio/6.mp3");
      file.play();
      // voce.stop();
      // voce = new SoundFile(this, "audio/v6.mp3");
      // voce.play();
      coloumnTextParagraph = "Come si configura l’evento per i DS?\n"+
                              "Per il 70,5% in apprendimento informale.\n"+
                              "Circa il 75% dei dirigenti dichiara che le iniziative di formazione,\n"+
                              "Eventi Capitali, vengono promosse con il coinvolgimento di altre reti.";
      primaDesrizione = "delle reti organizza seminari e incontri.";
      secondaDescrizione = "delle reti promuove iniziative di affiancamento con mentor o coach.";
      terzaDescrizione = "delle reti organizza percorsi on line.";

      firstTitle = "EVENTO/CAPITALE EVENTO";

      pctText1 = 55.6f;
      pctText2 = 8.6f;
      pctText3 = 13.9f;

      boidState = boidStateMachine.reset;
      bScene = true;    
      break;

      case 16:
      println("tScena08a : " + time() + " " + cntScene);
      overlay = true;
      if(!goToTarget.b)
      {
        boidState = boidStateMachine.attractor;
      }
      else if(goToTarget.b && boidState == boidStateMachine.text)
      {
        myTargetPtr.myTgt = new PVector(width+width/2,height/2);
        boidState = boidStateMachine.exitBoid;
      }
      bScene = true;
      break;

      case 17:
      println("tScena09 : " + time() + " " + cntScene);
      overlay = false;
      if(!goToTarget.b)
      {
        boidState = boidStateMachine.attractor;
      }
      else if(goToTarget.b && boidState == boidStateMachine.text)
      {
        myTargetPtr.myTgt = new PVector(width+width/2,height/2);
        boidState = boidStateMachine.exitBoid;
      }
      bScene = true;
      break;

      case 18 :
      println("END");
      bFinale = true;
      //bScene = true;
      exit();
      break; 

      default:
      break;  
    }
  }
  else if (bScene) 
  {
   // if(time().equals(tScena01))
    if(cntScene == int(tScena01))
    {
      tScena01 = "";
      actualScene = 1;
      bScene = false;
      
    }

    if(cntScene == int(tScena01a))
    {
      tScena01a = "";
      actualScene = 2;
      bScene = false;
    }
        
    if(cntScene == int(tScena02))
    {
      tScena02 ="";
      actualScene = 3;
      bScene = false;
    }

    if(cntScene == int(tScena02a))
    {
      tScena02a ="";
      actualScene = 4;
      bScene = false;
    }

    if(cntScene == int(tScena03))
    {
      tScena03 = "";
      actualScene = 5;
      bScene = false;
    }

    if(cntScene == int(tScena03a))
    {
      tScena03a = "";
      actualScene = 6;
      bScene = false;
    }

    if(cntScene == int(tScena04))
    {
      tScena04 = "";
      actualScene = 7;
      bScene = false;
    }

    if(cntScene == int(tScena04a))
    {
      tScena04a = "";
      actualScene = 8;
      bScene = false;
    }

    if(cntScene == int(tScena05))
    {
      tScena05 = "";
      actualScene = 9;
      bScene = false;
    }

    if(cntScene == int(tScena05a))
    {
      tScena05a = "";
      actualScene = 10;
      bScene = false;
    }

    if(cntScene == int(tScena06))
    {
      tScena06 = "";
      actualScene = 11;
      bScene = false;
    }

    if(cntScene == int(tScena06a))
    {
      tScena06a = "";
      actualScene = 12;
      bScene = false;
    }
    
    if(cntScene == int(tScena07))
    {
      tScena07 = "";
      actualScene = 13;
      bScene = false;
    }

    if(cntScene == int(tScena07a))
    {
      tScena07a = "";
      actualScene = 14;
      bScene = false;
    }

    if(cntScene == int(tScena08))
    {
      tScena08 = "";
      actualScene = 15;
      bScene = false;
    }

    if(cntScene == int(tScena08a))
    {
      tScena08a = "";
      actualScene = 16;
      bScene = false;
    }

    if(cntScene == int(tScena09))
    {
      tScena09 = "";
      actualScene = 17;
      bScene = false;
    }

    if(cntScene == int(tScena10))
    {
      tScena10 = "";
      
      actualScene = 18;
      bScene = false;
    }

  }

  cntScene++;
  //println(cntScene);
  return actualScene;

}

void showOverlay(boolean _overlay)
{
    if(_overlay)
    { 
      cnt++;
      if(cnt > 190)
        cnt = 190;
    }
    if(!overlay)
    { 
      //if(cnt >= 190)
        //first = true;
      //if(first)
      //{
        cnt--;
        if(cnt <= 0)
        cnt = 0;
      //}
     //cnt = 0;
    }

    fill(255,cnt);
    noStroke();
    rect(-1,60, width+2, 500);
}
float posx1,posx2,posx3;
void showOverlayFirstScene(boolean _overlay)
{
    if(bOverlayFirstScene)
    { 
      cntFirstScene++;
      if(cntFirstScene > 190)
        cntFirstScene = 190;
    }

    if(!bOverlayFirstScene)
    { 
      cntFirstScene--;
      if(cntFirstScene <= 0)
        cntFirstScene = 0;
    }

    pushStyle();
    fill(255,cntFirstScene);
    noStroke();
   // rect(-1,180, width+2, 380);
    rect(-1,60, width+2, 500);

    popStyle();

    pushStyle();
    float a = map(cntFirstScene, 0,190, 0,255);
    fill(0,0,0,a);
    textFont(font, 24);
    textAlign(CENTER,CENTER);


    if(!bOverlayOtherScene && bOverlayFirstScene)
    {
      title = "Chi sono i Dirigenti Scolastici?\n Il Ds è femmina nel 65,89%, mentre è maschio nel 34,11 %." + 
      '\n'+"L’età media è di 55 anni. Circa 80% ha tra i 51 e 65 anni.";
      v1 = "7325";
      v2 = "1571";
     // v3 = "5754";
      v3 = "";
      d1 = "Popolazione Dirigenti scolastici italiani.";
      d2 = "Partecipanti alla ricerca.";
      d3 = "";
      //d3 = "sono quelli che ancora possono\ndare il loro contributo.";
      size1 = pct(0.7325, 0, 250);
      size2 = pct(0.1571, 0, 250);
      size3 = pct(0.0, 0, 250);
      //size3 = pct(0.5754, 0, 250);
      hFont = 14;
      
      posx1 = pct(0.4, 0, width);
      posx2 = pct(0.6, 0, width);
    }
    else if (bOverlayOtherScene && bOverlayFirstScene)
    {
      
      title = "Cosa motiva la presenza in rete dei DS?" + 
      '\n'+"Il 57,7% è profondamente motivato dal condividere le conoscenze professionali con gli altri appartenenti alla rete." +
      '\n'+"Il 50,4% è d’accordo nel riconoscersi completamente negli intenti e nella missione condivisa della rete.";
      v1 = "83,7%";
      v2 = "91,8%";
      v3 = "92%";
      d1 = "d’accordo che appartenere a\nuna rete aiuta a contrastare\nil senso di isolamento.";
      d2 = "dei DS si sente del tutto o abbastanza\nmotivati a condividere le loro\nconoscenze personali con gli\naltri membri della rete.";
      d3 = "dei DS si riconosce del\ntutto o abbastanza nei compiti\ne negli intenti della rete.";
      size1 = pct(0.837, 0, 200);
      size2 = pct(0.918, 0, 200);
      size3 = pct(0.920, 0, 200);
      hFont = 22;
      
      posx1 = pct(0.3, 0, width);
      posx2 = pct(0.5, 0, width);
      posx3 = pct(0.7, 0, width);
   
    }
    // interspazio scena cerchi
    textLeading(30); 
    text(title, width/2, 150);
   // text(title, 0, -100, width, height); 
    popStyle();

    pushMatrix();
    fill(0,0,0,cntFirstScene);
    float h = 350.0f; // h cerchi
    
    ellipse(posx1, h, size1, size1);
    ellipse(posx2, h, size2, size2);
    ellipse(posx3, h, size3, size3);
    textFont(font, 22);
    textAlign(CENTER,CENTER);
    fill(255,255,255,cntFirstScene);

    text(v1, posx1, h);
    textFont(font, hFont);
    text(v2, posx2, h);
    textFont(font, 22);
    text(v3, posx3, h);
    fill(0,0,0,cntFirstScene);
    // testo sotto i cerchi
    textFont(font, 16);
    textLeading(15);
    text(d1, posx1, h+140);
    text(d2, posx2, h+140);
    text(d3, posx3, h+140);
    popMatrix();
}

float pct(float getPercentual, float from, float to)
{
    float pos = ((1-getPercentual) * from) + (getPercentual * to);
    return pos;
}
boolean bFinale = false;
int cntFinale = 0;

void finale(boolean _overlay)
{
    if(bFinale)
    { 
      cntFinale++;
      if(cntFinale >= 255)
        cntFinale = 255;
    }
  
    fill(255,cntFinale);
    noStroke();
    rect(0,0, width, height);
}