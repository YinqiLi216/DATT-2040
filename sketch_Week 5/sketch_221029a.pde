PImage x;
float theta;
float c = 1;
int[] shapes = {80, 20, 140, 250};
int shapecount = 0;

boolean shapeswitch = true;
static final int push = 256;

void setup() {
  size(1600, 1600);
}

void draw() {
  background(0);
  frameRate(24);
  stroke(frameCount%255, abs(sin(frameCount*0.2)*255), abs(cos(frameCount*0.1)*255));


  if (shapeswitch) {
    c = shapes[shapecount];
  } else {
    c = frameCount*0.75;
  }


  theta = radians(c);

  translate(width/2, (height/2)+100);

  ellipse(0, 0, 0, -height/8);

  translate(0, -height/8);

  branch(500);
}

void branch(float h) {
  h *= 0.33;
  if (h > 1) {
    pushMatrix();
    rotate(theta);
    ellipse(0, 0, 0, -h);
    translate(0, -h);
    branch(h);
    popMatrix();


    pushMatrix();
    rotate(-theta);
    ellipse(0, 0, 0, -h);
    translate(0, -h);
    branch(h);
    popMatrix();

    pushMatrix();
    translate(mouseX, mouseY);
    rotate(frameCount*0.5);
    stroke(frameCount%255, abs(sin(frameCount*0.2)*255), abs(cos(frameCount*0.1)*255));
    strokeWeight(2);
    line(-6, 0, 6, 0);
    strokeWeight(4);
    line(-4, 0, 4, 0);
    popMatrix();
  }
}


void mousePressed() {
  shapeswitch = !shapeswitch;
  save("out.png");
  ;
}
