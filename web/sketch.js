let photo1, photo2, mask0, mask;
let pg;
let imageWidth = 500, imageHeight = 500;

function setup() {
  createCanvas(imageWidth, imageHeight, WEBGL);
  imageMode(CENTER);
  photo1 = loadImage('data/photo1.png');
  photo2 = loadImage('data/photo2.png');
  mask0 = loadImage('data/mask_250_smooth.png');
  mask = mask0.get();
  PG_macro = createGraphics(imageWidth, imageHeight, WEBGL);
  PG_mask = createGraphics(imageWidth, imageHeight, WEBGL);
  PG_macro.imageMode(CENTER);
  PG_mask.imageMode(CENTER);
}

function draw() {
	clear();
	var mX2 = mouseX - width/2;
	var mY2 = mouseY - height/2;
	// image(photo1, 0, 0);

	PG_mask.clear();
	PG_mask.push();
	PG_mask.translate(mX2, mY2);
	PG_mask.rotateY(radians(map(mouseX, 0, width, 45, -45)));
	PG_mask.rotateX(radians(map(mouseX, 0, height, -45, 45)));
	PG_mask.imageMode(CENTER);
	// PG_mask.texture(mask0);
	// PG_mask.plane(PG_mask.width, PG_mask.height);
	PG_mask.image(mask0, 0, 0);
	PG_mask.pop();

	mask = PG_mask.get();
	photo2.mask(mask);

	PG_macro.clear();
	PG_macro.image(photo2, 0, 0);
	// PG_macro.texture(photo2);
	// PG_macro.plane(PG_macro.width, PG_macro.height);

	// noStroke();
	// texture(PG_macro);
	// plane(PG_macro.width, PG_macro.height);
	image(PG_macro, 0, 0);
	// image(PG_mask, 0, 0);
}