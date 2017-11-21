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
  int windSpeed = 0;


  // This is where the snowflakes will have a determined x and y,
  // velocity, speed, and size.

  // Constructor //
  Snowflake(int _x, int _y, float tempVX, int tempVY, int tempSize, int lineWeight) {
    x = _x;
    y = _y;
    vx = tempVX;
    vy = tempVY;
    SIZE = tempSize;
    THICKNESS = lineWeight;
    seed = (long)random(100);
  }

  // Method //

  void update() {
    // This will be where the snowflakes animate!
    // They will be falling down the screen, updating their y position based on SPEED
    // and their x position based on the sin/cos/tan wave MOTION DETECTION.
    // They will also be rotating on a 3D axis.
    // The number of snowflakes will change based on the TEMPERATURE reading.

    /* So, first:
     1. Check the temperature reading.
     (Change the number for amount of snowflakes based off of that)
     2. Check the wind velocity.
     (Change the SPEED based off of the wind velocity)
     (Update the y position)
     3. Check the motion detection.
     (Change the number for sin/cos/tan wave based off of that)
     (Update the x position)
     4. Update the rotation
     */
  }

  void snowflake() {
    pushMatrix();
    randomSeed(seed);
    //set background color
    //background(MAXCOLOR, MAXCOLOR, MAXCOLOR);
    //move the origin to the center of the canvas
    translate(x, y);
    rotateY(angleRotate);
    angleRotate += 0.01;

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
}