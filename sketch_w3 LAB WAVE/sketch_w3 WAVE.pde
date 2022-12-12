// ID
int cx, cy;
float secondsRadius;
float minutesRadius;
float hoursRadius;
float clockDiameter;
float lx = -900, ly = -900;

void setup() {
  size(600, 300);
  //clock set
  int radius = min(width, height) / 2;
  secondsRadius = radius * 0.72;
  minutesRadius = radius * 0.60;
  hoursRadius = radius * 0.50;
  clockDiameter = radius * 1.8;
  cx = width / 2;
  cy = height / 2;
}
void draw() {
  background(0);
  //clock
  fill(0);
  noStroke();
  ellipse(cx, cy, clockDiameter, clockDiameter);

  float s = map(second(), 0, 60, 0, TWO_PI) - HALF_PI;
  float m = map(minute() + norm(second(), 0, 60), 0, 60, 0, TWO_PI) - HALF_PI;

  stroke(100, 149, 237);
  strokeWeight(1);
  line(cx, cy, cx + cos(s) * secondsRadius, cy + sin(s) * secondsRadius);
  strokeWeight(4);
  line(cx, cy, cx + cos(m) * minutesRadius, cy + sin(m) * minutesRadius);
  strokeWeight(2);
  beginShape(POINTS);
  for (int a = 0; a < 360; a+=6) {
    float angle = radians(a);
    float x = cx + cos(angle) * secondsRadius;
    float y = cy + sin(angle) * secondsRadius;
    rect(x, y, (((a%30)==0)?10:2), (((a%30)==0)?10:2));
  }
  endShape();
  //line
  for (int i = 0; i < width; i++) {

    float wlen1 = 0.03;
    float w1 = tan(i*wlen1)*30;

    float wlen2 = 0.06;
    float w2 = 2+cos(frameCount*0.0002*i+wlen2)*10;

    float wlen3 = 0.04;
    float w3 = sin(lx*wlen3*0.0004)*30;
    
    float waveadd = (w1*w2*w3)/3;

    point(i, height/3+waveadd);
    stroke(50, 205, 50);// color
    if (lx < (width)-1) {
      line ( i, height/2+waveadd, lx, ly);
      lx = i;
      ly = height/2+waveadd;
    } else {
      lx = 0;
      ly = height/2;
    }
  }
}

void mouseDragged() {
  redraw();
  save("out.png");
}
