PVector[] sp;
PVector[] acc1;
PVector pos;
PVector acc2;
int speed = 200;
int num = 50;

int cols = 120;
int rows = cols;

float factor = 0.015;
int step;


void setup() {
  size(800, 800);

  pos = new PVector(random(width), random(height), random(80, 150));
  acc2 = new PVector(random(-speed, speed), random(-speed, speed), 0);
  sp = new PVector[num];
  acc1 = new PVector[num];

  for (int i = 0; i < num; i++) {
    sp[i] = new PVector(random(width), random(height), random(5, 70));
    acc1[i] = new PVector(random(-2, 2), random(-2, 2), 0);
  }
    
 
 
  stroke(255);
  noFill();
  background(100);
  strokeWeight(5);
  fill(255);
  step = (width / cols);
}

float inc = 0.5;

void draw() {
  background(47,79,79);

 pos.sub(acc2);

  if ( (pos.x > width) || (pos.x < 0)) {


    acc2.x = acc2.x * -1;
  }

  if ( (pos.y > width) || (pos.y < 0)) {

    acc2.y = acc2.y * -1;
  }

  fill(220,20,60);
  ellipse(pos.x, pos.y, pos.z, pos.z);
  strokeWeight(5);
  stroke(0);
   noFill();
  point(pos.x, pos.y);

  for (int j = 0; j < num; j++) {
    sp[j].add(acc1[j]);

    if ((sp[j].x > width) || (sp[j].x < 0)) {
      acc1[j].x = acc1[j].x * -1;
    }

    if ((sp[j].y > height) || (sp[j].y < 0)) {
      acc1[j].y = acc1[j].y * -1;
    }
    fill(230,230,250);
    ellipse(sp[j].x, sp[j].y, sp[j].z, sp[j].z);
  }
  float n;

  inc+= 0.0025;

  for (int y = 0; y < rows; y++) {
    for (int x = 0; x < cols; x++) {
      n = randomGaussian() *  80;
      float  cx = sin(n)*0.45;
      float cy = cos(n)*0.25;
      stroke( random(255), random(255), random(255));
      point(x * (step + cx), y * (step + cy));
    }
  }
}

void mousePressed() {
  speed = int(random(6));
  pos = new PVector(random(width), random(height), random(0,100));
   save("out.png");
}
