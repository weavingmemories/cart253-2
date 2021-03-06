/* The snowflake class will procedurally generate snowflakes with varying shapes and sizes
 every time, with a 'fall' method that will work with a sin/cos/tan wave- changes of the
 intensity of the wave based on motion detection and the amount of snowflakes based on
 the temperature displayed by Yahoo Weather. They will rotate on a 3D axis.
 */



class Snowflake {

  // Properties //

  // maximum RGB value
  final int MAXCOLOR = 255;
  // degrees in a circle
  final int CIRCLE = 360;
  // how many branches do the snowflakes have?
  final int NBRANCHES = 6;
  // how big are the snowflakes, in pixels?
  int SIZE = 100;
  // how many levels of branches do our snowflakes have?
  int DEPTH = 3;
  // how thick do we draw the lines?
  int THICKNESS = 12;
  // these arrays hold the randomized parameters for the snowflakes
  float[] fractions = new float[DEPTH];
  int[] angles = new int[DEPTH];

  float x;
  float y = 0;
  float vx;
  float vy;
  int size;
  long seed;
  float theta = 0;
  float angleRotate;
  float windSpeed = 0;
  SoundFile tone;


  // This is where the snowflakes will have a determined x and y,
  // velocity, speed, size, line thickness and tone assigned to them.

  // Constructor //
  Snowflake(int _x, int _y, float tempVX, int tempVY, int tempSize, int lineWeight, SoundFile _tone) {
    x = _x;
    y = _y;
    vx = tempVX;
    vy = tempVY;
    SIZE = tempSize;
    THICKNESS = lineWeight;
    seed = (long)random(100);
    tone = _tone;
  }

  // Method //

  void snowflake() {
    pushMatrix();
    randomSeed(seed);
    //set background color
    //background(MAXCOLOR, MAXCOLOR, MAXCOLOR);
    //move the origin to the center of the canvas
    translate(x, y, 100);
    rotateY(angleRotate);
    rotateZ(angleRotate);
    angleRotate += random(0.01);

    //rotate the canvas so the zero-direction is up
    rotate(radians(-CIRCLE/4));
    //generate three random branch positions and three random angles
    for (int i = 0; i<DEPTH; i++) {  
      // branch off at halfway, plus or minus a quarter of the way
      fractions[i] = 0.5 + 0.25*(random(1) - random(1));
      // branch off at 60 degrees, plus or minus 40 degrees
      angles[i] = int(60 + random(40) - random(40));
    }
    //six times, create a branch and then rotate the canvas 60 degrees
    for (int i = 0; i<NBRANCHES; i++) {
      branch(SIZE, 0);
      rotate(radians(CIRCLE/NBRANCHES));
    }
    popMatrix();
  }

  void branch(int size, int depth) {
    if (depth<DEPTH) {
      line(0, 0, size, 0);
      //each recursive branch calls "branch" four times until DEPTH is reached
      branch(int(fractions[depth]*size), depth+1);
      //the matrix stack is an important concept in Processing
      //pushMatrix is like bookmarking the canvas, and popMatrix rolls it back
      pushMatrix();
      translate(fractions[depth]*size, 0);
      branch(int(fractions[depth]*size), depth+1);
      pushMatrix();
      rotate(radians(-angles[depth]));
      branch(int(fractions[depth]*size), depth+1);
      popMatrix();
      pushMatrix();
      rotate(radians(angles[depth]));
      branch(int(fractions[depth]*size), depth+1);
      popMatrix();
      popMatrix();
    }
  }

  void display() {
    // This is where we draw the snowflakes every frame with the updated coordinates.
    // This will be where the snowflakes animate!
    // They will be falling down the screen, updating their y position based on SPEED
    // and their x position based on the sin/cos/tan wave MOTION DETECTION.
    // They will also be rotating on a 3D axis.

    if (isMoving == true) {
      windSpeed = constrain(windSpeed + 0.1, 0, 2);
    }
    if (isMoving == false) {
      windSpeed = constrain(windSpeed - 0.1, 0, 2);
    }
    vx = sin(theta);
    x += vx;
    x += windSpeed;
    stroke(255, 255, 255);
    strokeWeight(THICKNESS);
    pushMatrix();
    snowflake();
    popMatrix();
    y++;
    theta += random(0.005);
  }

  // If the snowflakes are off-screen, they will wrap around on both the x and y axis.

  void isOffScreen() {
    if (y > height+size) {
      y = 0;
    }
    if (x > width+size) {
      x = 0;
    }
  }

  void mouseOver() {

    // If the mouse is hovering over a snowflake, play a random tone from 1-5.

    if (dist(mouseX, mouseY, x, y) < SIZE/2) {
      println("Moused Over!");
      tone.play();
    }
  }
}