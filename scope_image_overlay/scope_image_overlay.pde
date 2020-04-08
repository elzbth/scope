

//photo1 is behind photo2
PGraphics PG_macro, PG_mask;
PImage photo1, photo2, mask0, mask;

int imageWidth = 500;
int imageHeight = 500;

//alternate implementation with mask array
int[] maskArray;

int maskRadius;

float maxDist;

int mX, mY, mX2, mY2;

float halfDiag = sqrt(pow(width,2)+pow(height,2))/2;

void setup() {
  size(500, 500, P3D);

  photo1 = loadImage("photo1.png");
  photo2 = loadImage("photo2.png");
  mask0 = loadImage("../scratchbook/mask_250_smooth.png");
  mask = mask0.get();

  PG_macro = createGraphics(width, height, P3D);
  PG_mask = createGraphics(width, height, P3D);

  maskArray = new int[width*height];
  maxDist = dist(0, 0, width, height);
  //frameRate(20);
}

void draw() {
  mX = mouseX;
  mY = mouseY;
  mX2 = (mX - width/2);
  mY2 = (mY - height/2);
  image(photo1, 0, 0);
  
  PG_mask.beginDraw();
  PG_mask.clear();
  PG_mask.imageMode(CENTER);
  PG_mask.pushMatrix();
  PG_mask.translate(PG_mask.width/2, PG_mask.height/2);
  // option 1 (work ok)
    PG_mask.rotateY(radians(map(mouseX, 0, width, 45, -45)));
    PG_mask.rotateX(radians(map(mouseY, 0, height, -45, 45)));
  
  //option 2 (needs some work)
    //float rotAngle = atan(mY2/(mX2+0.001));
    //PG_mask.rotate(rotAngle);
    //println(degrees(atan(mY2/(mX2+0.001))));
    //PG_mask.scale(map(dist(mX, mY, width/2, height/2), 0, halfDiag, 1, 1.5), 1, 1);
  PG_mask.image(mask0, mX2, mY2);
  PG_mask.popMatrix();
  PG_mask.endDraw();

  mask = PG_mask.get(); //pass contents of PG to image (so sizes match)
  photo2.mask(mask);

  PG_macro.beginDraw();
  PG_macro.clear();
  PG_macro.imageMode(CORNER);
  PG_macro.image(photo2, 0, 0);
  PG_macro.endDraw();

  // BLEND
  //int destWidth = floor(mask.width*(1+0.01*(mouseX-width/2)));
  //int destHeight = floor(mask.height*(1+0.01*(mouseY-height/2)));
  //PG_macro.blend(mask, 0, 0, mask.width, mask.height, mouseX-mask.width/2, mouseY-mask.height/2, mask.width, mask.height, MULTIPLY);

  // MASK

  //updateMask();
  //photo2.mask(maskArray);
  //image(photo2, 0, 0);
  
  image(PG_macro, 0, 0);
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
