
int cols = 25;
int rows = 25;
int stepx, stepy;


void setup() {
  size(600, 600);


  stepx = (width / cols);
  stepy = (height / rows);


  fill(0);

  noLoop();
}


int col = 10;
int row = 20;

void draw() {
  background(random(255), random(255), random(255));

  for (int i = 0; i < cols; i++) {
    for (int j = 0; j < rows; j++) {

      float x = i*stepx;
      float y = j*stepy;


      int linesize = stepy;


      stroke(random(0, 20), random(255), random(120, 255));
      strokeWeight(random(3));
      line(x, y, 350, 300);

      int dice = int(random(10));

      strokeWeight (random(10));

      switch(dice) {
      case 0:

        stroke(random(255), random(255), random(255));
        line(x, y, x+linesize, y);
        break;
      case 1:

        stroke(random(255), random(255), random(255));
        line(x, y, x, y+linesize);
        break;
      case 2:

        stroke(random(255), random(255), random(255));
        line(x, y, x-linesize, y);
        break;
      case 3:

        stroke(random(255), random(255), random(255));
        line(x, y, x, y-linesize);
        break;
      case 4:

        stroke(random(255), random(255), random(255));
        line(x, y-linesize, x, y-linesize);
        break;
      case 5:

        stroke(random(255), random(255), random(255));
        line(x, y, x-linesize, y-linesize);
        break;
      case 6:

        stroke(random(255), random(255), random(255));
        line(x-linesize, y, x, y-linesize);
        break;
      case 7:

        stroke(random(255), random(255), random(255));
        line(x+linesize, y, x, y+linesize);
        break;
      case 8:

        stroke(random(255), random(255), random(255));
        line(x, y+linesize, x, y-linesize);
        break;
      case 9:

        stroke(random(255), random(255), random(255));
        line(x, y, x+linesize, y-linesize);
        break;
      case 10:

        stroke(random(255), random(255), random(255));
        line(x+linesize, y+linesize, x-linesize, y-linesize);
        break;
      }
    }
  }
}
void keyPressed()
{
  if (key == 'b')
    background(0, 0, 255);
  if (key == 'r')
    background(255, 0, 0);
  if (key == 'g')
    background(0, 255, 0);
  else
    background(
      int(random(0, 255)),
      int(random(0, 255)),
      int(random(0, 255))
      );
}

void mouseDragged() {
  redraw();
  save("out.png");
}
