int elapsedFrames = 0;

ArrayList points = new ArrayList();
boolean drawing = false;
int tiempoDeVida=5000;

void setup(){
  smooth();
  size(displayWidth,displayHeight);
 
  background(255);
}
 
void draw(){
  if(drawing == true){
    PVector pos = new PVector();
    pos.x = mouseX;
    pos.y = mouseY;
 
    PVector vel = new PVector();
    vel.x = (0);
    vel.y = (0);
   
    Point punt = new Point(pos, vel, tiempoDeVida);
    points.add(punt);
  }
   
   
  for(int i = 0; i < points.size(); i++){
   Point localPoint = (Point) points.get(i);
   if(localPoint.isDead == true){
    points.remove(i);
   }
   localPoint.update();
   localPoint.draw();
  }
   
  elapsedFrames++;
}
 
 
void keyPressed(){
  if(key == ' '){
    for(int i = 0; i < points.size(); i++){
       Point localPoint = (Point) points.get(i);
       localPoint.isDead = true;
    }
    pushStyle();
    noStroke();
    fill(255);
    rect(0, 0, width, height);
    popStyle();
    drawing=false;
    
  }
}
 
void mousePressed(){
  drawing = true;
}
 
void mouseReleased(){
  drawing = false;
}
 
 
 
class Point{
   
  PVector pos, vel, noiseVec;
  float noiseFloat, lifeTime, age;
  boolean isDead;
   
  public Point(PVector _pos, PVector _vel, float _lifeTime){
    pos = _pos;
    vel = _vel;
    lifeTime = _lifeTime;
    age = 0;
    isDead = false;
    noiseVec = new PVector();
  }
   
  void update(){
    float noiseLevel=0.0025;//0.0025;
    float semillaTemporal=0.001;//0.001;
    noiseFloat = noise(pos.x * noiseLevel, pos.y * noiseLevel, elapsedFrames * semillaTemporal);
    noiseVec.x = cos(((noiseFloat -0.3) * TWO_PI) * 10);
    noiseVec.y = sin(((noiseFloat - 0.3) * TWO_PI) * 10);
     
    vel.add(noiseVec);
    vel.div(2);
    pos.add(vel);
     
    if(1.0-(age/lifeTime) == 0){
     isDead = true;
    }
     
    if(pos.x < 0 || pos.x > width || pos.y < 0 || pos.y > height){
     isDead = true;
    }
     
    age++;   
  }
   
  void draw(){   
    fill(0,20);
    //noStroke();
    stroke(0, 20);
    ellipse(pos.x, pos.y, 1-(age/lifeTime), 1-(age/lifeTime));
  }
};

