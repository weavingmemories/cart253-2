/* This sketch loads up a background of 1000 tiny static particles in the background, all ranging in size from 1-3 and are nearly white. On top of this, there is a paddle that can be controlled to move left and right with the corresponding arrow keys.
There is a 'ball' that appears in the middle of the screen that automatically starts by sliding towards the bottom right of the screen. If the paddle hits the ball, it bounces off and bounces off the walls until it returns downward to the paddle.
If the ball is not hit, and slides off the bottom of the screen, it reloads in the middle and slides back down towards the bottom right of the screen. */

color backgroundColor = color(0);

int numStatic = 1000;
int staticSizeMin = 1;
int staticSizeMax = 3;
color staticColor = color(200);

int paddleX;
int paddleY;
int paddleVX;
int paddleSpeed = 10;
int paddleWidth = 128;
int paddleHeight = 16;
color paddleColor = color(255);

int ballX;
int ballY;
int ballVX;
int ballVY;
int ballSpeed = 5;
int ballSize = 16;
int fillWhite = 255; // CHANGED: added fillWhite variable for the ball
int fillAlpha = 255; // CHANGED: added fillAlpha variable for the ball
color ballColor = color(fillWhite,fillAlpha); // changed the variables so that they can change over time.

// This sets up the screen size to 640 by 480, as well as calls the functions setupPaddle and setupBall.

void setup() {
  size(640, 480);
  
  setupPaddle();
  setupBall();
}

/* This sets the paddle's X position to half the width of the screen (the middle) and the Y position to the height of the screen minus the paddle height (leaves it nearly flush to the bottom of the screen).
It also sets the paddle's velocity on the X-axis to 0. */

void setupPaddle() {
  paddleX = width/2;
  paddleY = height - paddleHeight;
  paddleVX = 0;
}

// This sets the ball's X and Y coordinates to the middle of the screen, as well as setting the velocity along the X and Y axis to the variable ballSpeed (which is 5).

void setupBall() {
  ballX = width/2;
  ballY = height/2;
  ballVX = ballSpeed;
  ballVY = ballSpeed;
}

// This draws the background to the previously defined variable (black) as well as calls the functions drawStatic, updatePaddle, updateBall, drawPaddle, and drawBall on a loop. This is the order of operations of the main program.

void draw() {
  background(backgroundColor);

  drawStatic();

  updatePaddle();
  updateBall();

  drawPaddle();
  drawBall();
}

/* This function creates the 'static' (tiny squares in the background) with a for loop. It sets the initial variable 'i' to 0, increasing it by 1 per frame as long as it is less than the previously defined numStatic variable (1000).
It sets the x and y coordinates of the static to be random with a maximum of the width and height of the screen. It also sets the staticSize variable to random, within the constraints of staticSizeMin (1) and staticSizeMax (3).
It sets the static to be the fill color of staticColor (200), and finally creates the rectangles along the previously randomized x and y variables, and randomized staticSize variables.
This creates a maximum of 1000 tiny static squares at all times on the screen. */

void drawStatic() {
  for (int i = 0; i < numStatic; i++) {
   float x = random(0,width);
   float y = random(0,height);
   float staticSize = random(staticSizeMin,staticSizeMax);
   fill(staticColor);
   rect(x,y,staticSize,staticSize);
  }
  
  for(int c = 0; c < 255 ; c++) { // CHANGED: Added a for loop to change the static color every draw loop. It counts up until the color is white, and resets along the loop again on the next color on RGB.
    staticColor++;
  }
}

/* This function adds the paddle's velocity to the paddle's X coordinates, effectively updating its coordinates so it can effectively move across the screen.
// However, it is constrained within the values (the edge of the paddle to the width of the screen). */

void updatePaddle() {
  paddleX += paddleVX;  
  paddleX = constrain(paddleX,0+paddleWidth/2,width-paddleWidth/2);
}

/* This function adds the ball's velocity to its X and Y coordinates, effectively updating its coordinates so it can effectively move across the screen.
It also calls the functions handleBallHitPaddle, handleBallHitWall, and handleBallOffBottom, likely to check whether it has collided with the paddle, wall, or bottom of the screen. */

void updateBall() {
  ballX += ballVX;
  ballY += ballVY;
  
  handleBallHitPaddle();
  handleBallHitWall();
  handleBallOffBottom();
  checkBallLocation();
}

/* This function draws the paddle once it has been 'updated'. It is a centered rectangle with no border that is filled with the predetermined paddleColor (white).
It is placed along the coordinates of paddleX (which updates based on velocity), paddleY (static at height - paddleHeight), and is set to the predetermined paddleWidth(128) and paddleHeight(16). */

void drawPaddle() {
  rectMode(CENTER);
  noStroke();
  fill(paddleColor);
  rect(paddleX, paddleY, paddleWidth, paddleHeight);
}

/* This function draws the ball once it has been 'updated'. It is a centered rectangle with no border that is filled with the predetermined ballColor (white).
It is placed along the coordinates of ballX and ballY (which updates based on velocity) and is set to the predetermined ballSize (which is 16 by 16). */

void drawBall() {
  rectMode(CENTER);
  noStroke();
  fill(ballColor);
  rect(ballX, ballY, ballSize, ballSize);
}

/* This function determines whether the ball has overlapped the paddle. If it has been returned as true, then it updates the ball's position along the Y-axis by using the paddle's Y coordinate and subtracting it by the paddle height(divided by 2)
and subtracting it by the ball size (divided by 2). It then switches the ball's velocity along the Y axis to a negative, making it go in the opposite direction (up). */

void handleBallHitPaddle() {
  if (ballOverlapsPaddle()) {
    ballY = paddleY - paddleHeight/2 - ballSize/2;
    ballVY = -ballVY;
    fillAlpha -=5; // If the ball hits the paddle, it will slowly decrease the opacity of the ball every time, making the game more challenging.
    ballColor = color(fillWhite,fillAlpha);
  }
}

// This boolean detects whether the ball has overlapped the paddle. If it has, then it returns a true value (activating handleBallHitPaddle's if statement). If it doesn't, then it returns a false value.

boolean ballOverlapsPaddle() {
  if (ballX - ballSize/2 > paddleX - paddleWidth/2 && ballX + ballSize/2 < paddleX + paddleWidth/2) {
    if (ballY > paddleY - paddleHeight/2) {
      return true;
    }
  }
  return false;
}

// This function determines whether the ball has hit the bottom of the screen. If it has been returned as true, then it will set the ball's x and y coordinates back to the middle of the screen.

void handleBallOffBottom() {
  if (ballOffBottom()) {
    ballX = width/2;
    ballY = height/2;
    fillAlpha = 255; // CHANGED: Once the ball comes off the screen, it will reset to opaque.
    ballColor = color(fillWhite,fillAlpha);
  }
}

// This boolean detects whether the ball has touched the bottom of the screen. If it has, then it returns a true value (activating handleBallOffBottom's if statement). If it doesn't, then it returns a false value.

boolean ballOffBottom() {
  return (ballY - ballSize/2 > height);
}

/* This function determines whether the ball has hit one of the 3 other 'walls' (top, left, and right sides of the screen). If the ball touches a side of the screen, it sets the ball's velocity along the X or Y axis to negative,
making it move across the 'opposite' side of the screen respectively. */

void handleBallHitWall() {
  if (ballX - ballSize/2 < 0) {
    ballX = 0 + ballSize/2;
    ballVX = -ballVX;
  } else if (ballX + ballSize/2 > width) {
    ballX = width - ballSize/2;
    ballVX = -ballVX;
  }
  
  if (ballY - ballSize/2 < 0) {
    ballY = 0 + ballSize/2;
    ballVY = -ballVY;
  }
}

void checkBallLocation() { // CHANGED: This function checks the ball's location along the 4 quadrants of the screen, and accordingly changes the paddle color.
  if (ballX < 320 && ballY < 240) { // Upper Left
    paddleColor = #00FFFF;
  }
  if (ballX < 320 && ballY > 240) { // Lower Left
    paddleColor = #FF00FF;
  }
  if (ballX > 320 && ballY < 240) { // Upper Right
    paddleColor = #ff8000;
  }
  if (ballX > 320 && ballY > 240) { // Lower Right
    paddleColor = #8300CD;
  }
}

/* This function assesses key presses. If the LEFT key is pressed, then it sets the paddle's velocity along the X-axis to negative paddleSpeed (moving it to the left of the screen).
If the RIGHT key is pressed, then it sets the paddle's velocity along the X-axis to positive paddleSpeed (moving it to the right of the screen). */

void keyPressed() {
  if (keyCode == LEFT) {
    paddleVX = -paddleSpeed;
  } else if (keyCode == RIGHT) {
    paddleVX = paddleSpeed;
  }
}

/* This function assesses when the keys are released. If the LEFT key is released when the paddle's velocity along the X-axis is less than 0, it sets it to 0 (stopping it from moving.)
If the RIGHT key is released when the paddle's velocity along the X-axis is greater than 0, it sets it to 0 (stopping it from moving).
*/

void keyReleased() {
  if (keyCode == LEFT && paddleVX < 0) {
    paddleVX = 0;
  } else if (keyCode == RIGHT && paddleVX > 0) {
    paddleVX = 0;
  }
}