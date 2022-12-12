PImage img; 

float omx;
float omy;
float x;
PImage p1;
int frameSpeed;
float t;


void setup() {
  imageMode(CENTER);
  background(0);
   x = width;
    frameSpeed = 16;
    frameRate(frameSpeed);
    p1 = loadImage("R.png");
    t = 0;

}

void settings(){
   img = loadImage("R.png");
  size(img.width,img.height, P2D);}

void draw() {
  
  background(0);
  
  int x = int(map(noise(t),0,1,0,width-300));
  int y = int(map(noise(t+5),0,1,0,height-170));
  int wi = int(map(noise(t+10),0,1,0,320));
  int hi = int(wi * 15 /8);
  
  int tiX = 15;
  int tiY = 15;

  int tiW = int(width*2/15);
  int tiH = int(height*2/15);

  
  if(mousePressed == true){
    float mx = mouseX;
    float my = mouseY; 
    
    float xl = lerp(omx,mx, 0.05);
    float yl = lerp(omy,my, 0.02);
    
    omx = xl;
    omy = yl;
    
  }
  
  for (int y2 = 0; y2 < tiY; y2++) {
  for (int x2 = 0; x2 < tiX; x2++) {

      int wave = int(tan(((frameCount+omx)/3) * 0.02 + ( x2 * y2 ) * 0.09) * 100);
       int wave2 = int(sin(((frameCount+omy)/3) * 0.02 + ( x2 * y2 ) * 0.06) * 100);
    
      int sx = x2*tiW+wave;
      int sy = y2*tiH+wave2;
      int sw = x2+tiW;
      int sh = y2+tiH;

      int dx = y2*tiW;
      int dy = x2*tiH;
      int dw = tiW;
      int dh = tiH;
      
      copy(img, sx, sy, sw, sh, dx, dy, dw, dh);
      copy(p1,x,y,wi,hi,600,115,600,600);
      t += 0.05;
      
    }
  }
}
