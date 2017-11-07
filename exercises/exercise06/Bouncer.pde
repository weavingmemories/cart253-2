// Bouncer
//
// A class that defines a circle that can bounce around on the screen
// at a specific velocity.
// CHANGED: Added noise function to the movement so the bouncers move like little creatures.
// CHANGED: Also added ease function to the movement so the bouncers move towards the brightest pixel.

class Bouncer {
  
  // The image loaded for the Mosquito
  


  float tx = random(0, 100);
  float ty = random(0, 100);
  float easing = 0.05;
  float speed = 10;


  // Variables for position
  float x;
  float y;

  // Variables for velocity
  float vx;
  float vy;

  // The size of the Bouncer
  float size;

  // The current fill colour of the Bouncer
  color fillColor;

  // The default fill colour of the Bouncer
  color defaultColor;

  // Bouncer(tempX,tempY,tempVX,tempVY,tempSize,tempDefaultColor)
  //
  // Creates a Bouncer with the provided values by remembering them.

  Bouncer(float tempX, float tempY, float tempVX, float tempVY, float tempSize) {
    x = tempX;
    y = tempY;
    vx = tempVX;
    vy = tempVY;
    size = tempSize;
    mosquito = loadImage("mosquito.gif");
    
  }

  // update()
  //
  // Adds the Bouncer's current velocity to its position
  // and checks for bouncing off the walls.
  void update() {
    float vx = speed * (noise(tx) * 2 - 1);
    float vy = speed * (noise(ty) * 2 - 1);
    x += vx;
    y += vy;

    handleBounce();
  }

  // handleBounce()
  //
  // Checks if the bouncer is overlapping a side of the window
  // and if so reverses its velocity appropriately

  void handleBounce() {
    // Check the left and right
    if (x - size/2 < 0 || x + size/2 > width) {
      // Bounce on the x-axis
      vx = -vx;
    }

    // Check the top and bottom
    if (y - size/2 < 0 || y + size/2 > height) {
      // Bounce on the y-axis
      vy = -vy;
    }

    // Make sure the Bouncer isn't off the edge
    x = constrain(x, size/2, width-size/2);
    y = constrain(y, size/2, height-size/2);
  }

  // display()
  //
  // Draw an ellipse in the Bouncer's location, with its size
  // and with its fill
  void display() {
    noStroke();
    fill(fillColor);
float targetX = brightestPixelX;
  float dx = targetX - x;
  x += dx * easing;
  
  float targetY = brightestPixelY;
  float dy = targetY - y;
  y += dy * easing;
    image(mosquito, x, y, size, size);
    tx += 0.01;
    ty += 0.01;
  }
}