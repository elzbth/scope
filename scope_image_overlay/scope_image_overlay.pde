

//photo1 is behind photo2
PImage photo1, photo2;


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
  photo1 = loadImage("photo1.png");
  photo2 = loadImage("photo2.png");
  maskArray = new int[width*height];
  maxDist = dist(0, 0, width, height);
  frameRate(20);
}

void draw() {
  background(0);
  image(photo1, 0, 0);
  updateMask();
  photo2.mask(maskArray);
  image(photo2,0,0);
}


//update maskArray to be a hole of 0s around the mouse pointer position
void updateMask(){
  int counter = 0;
  int maskValue = 0;
  for(int i = 0; i < width; i++) {
    for(int j = 0; j < height; j++) {
      mX = mouseX;
      mY = mouseY;
      float distance = dist(mY, mX, i, j);
      println(mX, mY);
      //float maskValue = map(distance, 0.0, maxDist, 0.0,255.0);
      if (distance <= 50){
       maskValue = 255; 
      }
      else{
       maskValue = 0; 
      }
       maskArray[counter] = maskValue;
       counter +=1;
      
    }
  }
  
}
