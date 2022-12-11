import ddf.minim.analysis.*;
import ddf.minim.*;

AudioPlayer BGM;
Minim minim;
FFT fft;

//grid = 30*30
int grid=30;

PImage img;
PImage head;
PImage body;
PImage food;

int snake_len = 3;
int snake_len_max = 100;
int[] x = new int [snake_len_max];
int[] y = new int [snake_len_max];
int snake_headx;
int snake_heady;

char snake_dir = 'R';
char snake_dir_temp;
// set pause
int game_pause = 0;
//set gameover
boolean game_over = false;
boolean game_begin = false;

//speed of snake
int speed = 5;
//set time system
int time_saved;
int time_passed;
int time_interval;

//set food
//if true, food exists in broad
boolean food_key = true;
int foodx;
int foody;

void setup() {
  
  size(625, 625, P2D);
  frameRate(30);

  //set BGM
  minim = new Minim(this);
  BGM = minim.loadFile("cp5.mid", 1024);
  BGM.loop();

  pushMatrix();
  img = loadImage("caodi.png");
  head = loadImage("xiaoren.png");
  body = loadImage("yang2.png");
  food = loadImage( "yang1.png");

  background(img);
  translate(width/2, height/2 - 50);

  fill(#424200);
  textAlign(CENTER);
  textSize(120);
  text("Sheep", 0, 0);

  fill(#737300);
  textSize(50);
  text("Press 'R' to Start.", 0, 250);
  popMatrix();
  time_saved = millis(); //set time
}

void draw() {
  if (keyPressed && (key=='r') ) {
    game_begin = true;
  }
  if (game_again()) {
    return;
  }
  time_interval = 1000/speed;
  time_passed = millis() - time_saved;

  //snake move
  if (time_passed > time_interval && snake_dir != 'P' && game_begin) {
    img = loadImage("caodi.png");
    background(img);

    switch(snake_dir) {
    case 'L':
      snake_headx -= grid;
      break;
    case 'R':
      snake_headx += grid;
      break;
    case 'D':
      snake_heady += grid;
      break;
    case 'U':
      snake_heady -= grid;
      break;
    }

    //food
    food_new(width, height);

    if ( snake_headx == foodx && snake_heady == foody){
      food_key = true;
      snake_len++;
      if ( snake_len%5 ==1) {
        speed ++;
      }
      speed = min(10, speed);
    }


    for (int i=snake_len-1; i>0; i--) {
      x[i] = x[i-1];
      y[i] = y[i-1];
    }
    x[0] = snake_headx;
    y[0] = snake_heady;

    if (snake_headx < 0) {
      snake_headx = width;
    } else if (snake_headx > width ) {
      snake_headx = 1;
    }

    if (snake_heady < 0) {
      snake_heady = height;
    } else if (snake_heady > height ) {
      snake_heady = 1;
    }

    //draw snakeHead
    stroke(0);
    strokeWeight(0);
    fill(255, 0);
    //head mapping
    image(head, x[0], y[0]);
    rect(x[0], y[0], grid, grid);

    //draw snakeBody
    fill(255, 0);
    for (int i=1; i<snake_len; i++) {
      //body mapping
      image(body, x[i], y[i]);
      rect(x[i], y[i], grid, grid);
    }
    if (snake_die() ) {
      return;
    }
    time_saved = millis();
  }
}


//keyboard
void keyPressed() {
  if (key == 'p' ) {
    game_pause++;
    if ( game_pause%2 == 1 ) {
      snake_dir_temp = snake_dir;
      snake_dir = 'P';
    } else {
      snake_dir = snake_dir_temp;
    }
  }
  if (snake_dir != 'P' && key == CODED) {
    switch(keyCode) {
    case LEFT:
      snake_dir = 'L';
      break;
    case RIGHT:
      snake_dir = 'R';
      break;
    case DOWN:
      snake_dir = 'D';
      break;
    case UP:
      snake_dir = 'U';
      break;
    }
  } else if   ( snake_dir != 'P' ) {
    switch(key) {
    case 'a':
      snake_dir = 'L';
      break;
    case 'd':
      snake_dir = 'R';
      break;
    case 's':
      snake_dir = 'D';
      break;
    case 'w':
      snake_dir = 'U';
      break;
    }
  }
}

//new food
void food_new(int maxWidth, int maxHeight) {
  fill(255, 0);
  image(food, foodx, foody);  //food mapping
  int food_outbody =0;
  if (food_key) {
    while (food_outbody==0 ) {
      food_outbody = 1;
      //random new food
      foodx = int( random(0, maxWidth)/grid ) * grid;
      foody = int( random(0, maxHeight)/grid ) * grid;
      for (int i=snake_len-1; i>=0; i--) {
        if ( foodx == x[i] && foody == y[i] ) {
          food_outbody = 0;
        }
      }
    }
  }
  rect(foodx, foody, grid, grid);
  food_key = false;
}

//snake dead
boolean snake_die() {
  if (snake_len>3) {
    for (int i=1; i<snake_len; i++) {
      if (snake_headx==x[i] && snake_heady == y[i]) {
        show_gameover();
        return true;
      }
    }
  }
  return false;
}

//dead UI
void show_gameover() {
  game_over = true;
  pushMatrix();

  img = loadImage("End.png");
  background(img);
  translate(width/2, height/2 - 50);
  fill(#F75000);
  textAlign(CENTER);
  textSize(85);
  text("Score ", 0, 0);
  text(snake_len - 3, 0, 50);

  fill(#D94600);
  textSize(50);
  text("Press 'R' to restart.", 0, 260);
  popMatrix();
}


boolean game_again() {
  if (game_over && keyPressed && (key=='r') ) {
    snake_start();
  }
  return game_over;
}

void snake_start() {
  img = loadImage("caodi.png");
  background(img);
  snake_len = 2;
  game_over = false;
  snake_headx = 0;
  snake_heady = 0;
  snake_dir = 'R';
  speed = 5;
}
