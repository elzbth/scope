

//photo1 is behind photo2
PGraphics PG_micro, PG_macro;
PImage photo1, photo2, mask;

int imageWidth = 500;
int imageHeight = 500;

//alternate implementation with mask array
int[] maskArray;

int maskRadius;

float maxDist;

int mX;
int mY;

void setup() {
  size(500, 500, JAVA2D);
  imageMode(CENTER);

  photo1 = loadImage("photo1.png");
  photo2 = loadImage("photo2.png");

  PG_micro = createGraphics(width, height, JAVA2D);
  PG_macro = createGraphics(width, height, JAVA2D);

  PG_macro.beginDraw();
  PG_macro.imageMode(CENTER);
  PG_macro.image(photo2, width/2, height/2);
  PG_macro.endDraw();

  mask = loadImage("../scratchbook/mask_250_smooth.png");
  maskArray = new int[width*height];
  maxDist = dist(0, 0, width, height);
  frameRate(20);
}

void draw() {
  PG_micro.beginDraw();
  PG_macro.imageMode(CORNER);
  PG_micro.image(photo1, 0, 0);
  PG_micro.endDraw();  

  PG_macro.beginDraw();
  PG_macro.imageMode(CORNER);
  PG_macro.image(photo2, 0, 0);

  //int destWidth = floor(mask.width*(1+0.01*(mouseX-width/2)));
  //int destHeight = floor(mask.height*(1+0.01*(mouseY-height/2)));
  PG_macro.blend(mask, 0, 0, mask.width, mask.height, mouseX-mask.width/2, mouseY-mask.height/2, mask.width, mask.height, MULTIPLY);
  PG_macro.endDraw();
  //updateMask();
  //photo2.mask(maskArray);
  //image(photo2, 0, 0);

  image(PG_micro, width/2, height/2);
  image(PG_macro, width/2, height/2);
}

//update maskArray to be a hole of 0s around the mouse pointer position
void updateMask() {
  int counter = 0;
  int maskValue = 0;
  for (int i = 0; i < width; i++) {
    for (int j = 0; j < height; j++) {
      mX = mouseX;
      mY = mouseY;
      float distance = dist(mY, mX, i, j);
      println(mX, mY);
      //float maskValue = map(distance, 0.0, maxDist, 0.0,255.0);
      if (distance <= 50) {
        maskValue = 255;
      } else {
        maskValue = 0;
      }
      maskArray[counter] = maskValue;
      counter +=1;
    }
  }
}
