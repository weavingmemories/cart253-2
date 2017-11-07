// DISCO CUBES //
// This program is basically a bunch of 3D boxes created within the space of one box.
// However, they're slowly becoming smaller. (Oh no!)
// You can increase their size by holding down the mouse, which will spread the boxes out.
// There is also a spotlight controlled by the mouse cursor's position on the screen.
// It randomly keeps changing colors every loop, creating a 'disco' effect.

// VARIABLES //

float theta = 0;
float WIDTH = 50;
float HEIGHT = 50;
float DEPTH = 50;
int z = 0;
int x = 0;
int y = 0;
int randomRed = 50;
int randomGreen = 50;
int randomBlue = 50;
boolean isMousePressed = false;

// SETUP //

void setup() {
  // Setting the screen to be 640 by 480, and giving it a Z axis and allowing 3D shapes to be drawn.
  size(640, 480, P3D);
}

// DRAW LOOP // 

void draw() {
  background(0);
  pushMatrix();
  
  // If the mouse is pressed down, increase the WIDTH, HEIGHT, and DEPTH of the origin point,
  // which makes the boxes spread out from their origin point.
  
    if (isMousePressed == true) {
      WIDTH++;
      HEIGHT++;
      DEPTH++;
    }
  // If the mouse is not pressed down, decrease the WIDTH, HEIGHT, and DEPTH of the origin point,
  // which makes the boxes come closer to the origin point and become smaller.
  
    if (isMousePressed == false) {
      WIDTH--;
      HEIGHT--;
      DEPTH--;
    }
    
  // This spotlight function, with randomized color values, follows the mouseX and mouseY position on the screen for the position.
spotLight(randomRed, randomGreen, randomBlue, mouseX/2, mouseY/2, 0, mouseX*2, mouseY*2, 0, 90, 2);

  // This translates the origin point of the box to the center of the screen, as well as rotates it by 45 degrees translated to radians, and by theta.
  translate(width/2, height/2, 0);
  rotateX(radians(45));
  rotateY(theta);
  
  // This is the same for loop used in the midterm(static for the paddles in Pong), except adapted for 3 dimensions.
  // This makes 50 boxes and gives the same effect.
  // This loop also picks a new color for the spotlight effect every time.
  for (int i = 0; i < 50; i++) {
    pickNewColor();
    pushMatrix();
    translate(x + floor(random(-WIDTH/2, WIDTH/2)), y + floor(random(-HEIGHT/2, HEIGHT/2)), z + floor(random(-DEPTH/2, DEPTH/2)));
    box(25);
    popMatrix();
  }
  theta += 0.01;
  popMatrix();
}

// Set the booleans according to when the mouse is pressed (true) and released (false)
// to make holding the mouse down for steady effect possible.

void mousePressed() {
isMousePressed = true;
}

void mouseReleased() {
  isMousePressed = false;
}

// This function picks a new color, picking a random red, green, and blue value
// and resetting the values.
void pickNewColor() {
  randomRed = floor(random(255));
  randomGreen = floor(random(255));
  randomBlue = floor(random(255));
}