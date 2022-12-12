Collider[] collide;

float angle = random(360);
float R = random(360);
int t = 0;
int particles = 200;
float bounce = 0.007;
float gravity = 0.004;
float friction = -0.9;


void setup() {
  size(700, 700);

  collide = new Collider[particles];

  for (int i = 0; i < particles; i++) {
    collide[i] = new Collider(new PVector(random(width), random(height)), random(20), i);
  }
  noStroke();
  fill(249,0,205);
}


void draw() {
  background(0);
  float angleRad = radians(angle);
 
  for (Collider c : collide) {
    c.move();
    c.display();
  }
  for(int i = 0; i < 360; i+=15){
    float w = sin(radians(t+i )) * 200;
    w = abs(w);
    float x = cos(radians(i)) * 25 + width / 2;
    float y = sin(radians(i)) * 100 + height / 2;
    float col=map(i,0,360,120,255);       
    noStroke();
    fill(col,0,205);
    ellipse(x, y, w, w);
 }
   t++;
   
  ellipse(width/2, height/2, R, R);
  fill(255);
  arc(width/2, height/2, R, R, PI+angleRad, PI+PI+angleRad);
  float posX = cos(angleRad) * R/4 + width/2;
  float posY = sin(angleRad) * R/4 + height/2;
  float posX2 = cos(angleRad + PI) * R/4 + width/2;
  float posY2= sin(angleRad + PI) * R/4 + height/2;
  noStroke();
  ellipseMode(CENTER);
   if (mousePressed) {
    fill(255);
  } else {
    fill(249,0,205);
  }
  ellipse(posX, posY, R/2, R/2);

      if (mousePressed) {
    fill(249,0,205);
  } else {
    fill(255);
  }
  ellipse(posX, posY, R/6, R/6);
   
       if (mousePressed) {
    fill(249,0,205);
  } else {
    fill(255);
  }
  ellipse(posX2, posY2, R/2, R/2);

      if (mousePressed) {
    fill(255);
  } else {
    fill(249,0,205);
  }
  ellipse(posX2, posY2, R/6, R/6);
}

class Collider {

  PVector loc;

  PVector force = new PVector(0, 0);

  float diameter;
  int id;

  Collider(PVector locin, float di, int idi) {

    loc = locin;
    diameter = di;

    id = idi;
  }

  void move() {

    force.y += gravity;
    loc.x += force.x;
    loc.y += force.y;

    if (loc.x + diameter/3 > width) {
      loc.x = width - diameter/3;
      force.x *= friction;
    } else if (loc.x - diameter/3 < 0) {
      loc.x = diameter/3;
      force.x *= friction;
    }
    if (loc.y + diameter/3 > height) {
      loc.y = height - diameter/3;
      force.y *= friction;
    } else if (loc.y - diameter/3 < 0) {
      loc.y = diameter/3;
      force.y *= friction;
    }
  }

  void display() {
    
    if (mousePressed) {
    fill(249,0,205);
  } else {
    fill(255);
  }
    ellipse(loc.x, loc.y, diameter, diameter);
  }
}
void keyPressed() {
  save("out.png");
}
