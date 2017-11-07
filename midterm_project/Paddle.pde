// Paddle
//
// A class that defines a paddle that can be moved up and down on the screen
// using keys passed through to the constructor.

class Paddle {

  /////////////// Properties ///////////////

  // Default values for speed and size
  int SPEED = 5;
  int HEIGHT = 70;
  int WIDTH = 16;

  // The position and velocity of the paddle (note that vx isn't really used right now)
  int x;
  int y;
  int vx;
  int vy;

  // The fill color of the paddle. Added fillRed variables to
  // slowly fade the paddle in certain circumstances.
  int fillRed = 255;
  int fillGreen = 255;
  int fillBlue = 255;
  int fillAlpha = 255;
  color paddleColor = color(fillRed, fillGreen, fillBlue, fillAlpha);

  // The characters used to make the paddle move up and down, defined in constructor
  char upKey;
  char downKey;

  // This variable tracks the amount of 'static' that comprises the paddles.
  int energyNumber = 100;


  /////////////// Constructor ///////////////

  // Paddle(int _x, int _y, char _upKey, char _downKey)
  //
  // Sets the position and controls based on arguments,
  // starts the velocity at 0

  Paddle(int _x, int _y, int paddleSpeed, char _upKey, char _downKey, int _HEIGHT) {
    x = _x;
    y = _y;
    vx = 0;
    vy = 0;
    SPEED = paddleSpeed;
    HEIGHT = _HEIGHT;
    paddleColor = color(fillRed, fillGreen, fillBlue, fillAlpha);

    upKey = _upKey;
    downKey = _downKey;
  }


  /////////////// Methods ///////////////

  // update()
  //
  // Updates position based on velocity and constraints the paddle to the window

  void update() {
    // Update position with velocity (to move the paddle)
    x += vx;
    y += vy;
    // Constrain the paddle's y position to be in the window
    y = constrain(y, 0 + HEIGHT/2, height - HEIGHT/2);
  }

  // display()
  //
  // Display the paddle at its location

  void display() {
    // Set display properties
    noStroke();
    if (fadeDepression == true) {
      println(fillAlpha);
      fillAlpha--;
      paddleColor = color(fillRed, fillGreen, fillBlue, fillAlpha);
    }
    fill(paddleColor);
    rectMode(CENTER);
    // Draw the paddle as a lot of tiny rectangles, basically 'static'.

    for (int i = 0; i < energyNumber; i++) {
      rect(x + floor(random(-WIDTH/2, WIDTH/2)), y + floor(random(-HEIGHT/2, HEIGHT/2)), 2, 2);
    }
  }


  // fadeColor()
  //
  // Fades the color slowly to make the paddle harder to see.

  // keyPressed()
  //
  // Called when keyPressed is called in the main program

  void keyPressed() {
    // Check if the key is our up key
    if (key == upKey) {
      // If so we want a negative y velocity
      vy = -SPEED;
    } // Otherwise check if the key is our down key 
    else if (key == downKey) {
      // If so we want a positive y velocity
      vy = SPEED;
    }
  }

  // keyReleased()
  //
  // Called when keyReleased is called in the main program

  void keyReleased() {
    // Check if the key is our up key and the paddle is moving up
    if (key == upKey && vy < 0) {
      // If so it should stop
      vy = 0;
    } // Otherwise check if the key is our down key and paddle is moving down 
    else if (key == downKey && vy > 0) {
      // If so it should stop
      vy = 0;
    }
  }
}