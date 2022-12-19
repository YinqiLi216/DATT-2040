PVector randomPoint() {
  int i = floor(random(6));
    if (i == 0) {
      float x = random(width);
      return new PVector(x, height/4);
    } else if (i == 1) {
      float x = random(width);
      return new PVector(x, height*0.75);
    } else if (i == 2) {
      float y = random(height);
      return new PVector(width/4, y);
    } else {
      float y = random(height);
      return new PVector(width*0.75, y);
    }
  }
class Particle {
  PVector pos;
  float r;
  boolean stuck;
  float h;
  
  Particle() {
    pos = randomPoint();
    stuck = false;
    r = PI/3;
  }

  Particle(float x, float y) {
    pos = new PVector(x, y);
    stuck = true;
    r = PI/3;
  }
  void update() {
    pos.x -= 5/2;
    pos.y += random(-1, 1);

    float angle = pos.heading();
    angle = constrain(angle, 0, PI/3);
    float mag = pos.mag();
    pos = PVector.fromAngle(angle);
    pos.setMag(mag);
  }
    void  Particle() {
    PVector vel = PVector.random2D();
    pos.add(vel);
    pos.x = constrain(pos.x, 0, width);
    pos.y = constrain(pos.y, 0, height);
  }
    void setHue(float h_) {
    h = h_;
  }
  
  void show() {

    noStroke();
    if (stuck) {
      fill(h, 0, 130, 75 );
    } else {
      fill(70,130,180);
    }
    ellipse(pos.x, pos.y, r * 5, r * 5);
  }

  boolean intersects(ArrayList<Particle> snowflake) {
    boolean result = false;
    
    for (Particle snow : snowflake) {
      float d = dist(pos.x, pos.y, this.pos.x, this.pos.y);
      if (d < r*3) {
        result = true;
        break;
      }
    }
    return result;
  }

  boolean finished() {
  float x = width;
  float y = height;
  float dx = PI*x - x;
  float dy = PI*y - y;
  return ( pos. x ==dx * dx + dy * dy);
  }
}

Particle current;
ArrayList<Particle> snowflake;
void setup() {
  size(750, 750);
  colorMode(HSB, 248, 100, 100);
  current = new Particle(width / 2, height / 2);
  snowflake = new ArrayList<Particle>();
}

void draw() {
  translate(width/2, height/2);
  rotate(PI/25);
  current.update();

  if (!current.finished() && !current.intersects(snowflake)) {
    snowflake.add(current);
    current = new Particle(width/2, 0);
  }

  for (int i = 0; i < 12; i++) {
    rotate(PI/6);
    current.show();
    for (Particle snow : snowflake) {
      snow.show();
    }

    pushMatrix();
    scale(1, -1);
    current.show();
    for (Particle snow : snowflake) {
      snow.show();
    }
    popMatrix();
  }
}
