/* This class creates what we know as the two bouncers (balls) bouncing along the edges of the screen. It will define what the bouncers are,
 how they move, and how they react to bouncing off of walls, as well as how they react to the mouse hovering over them. */

class Bouncer {
  /* These are the properties for the class. This signifies that they will have an x position, y position, velocity along x and y axis,
   a size, a color, as well as a default color and a color when the mouse hovers over it. */
  int x;
  int y;
  int vx;
  int vy;
  int size;
  color fillColor;
  color defaultColor;
  color hoverColor;
  boolean isMouseClicked;

  /* Within the constructor, there are arguments, signifying that each bouncer can be created differently. Every time one is created,
   a different X and Y location can be inputted, as well as its velocity, size, default color, as well as color when the mouse hovers over it. */

  Bouncer(int tempX, int tempY, int tempVX, int tempVY, int tempSize, color tempDefaultColor, color tempHoverColor) {
    x = tempX;
    y = tempY;
    vx = tempVX;
    vy = tempVY;
    size = tempSize;
    defaultColor = tempDefaultColor;
    hoverColor = tempHoverColor;
    fillColor = defaultColor;
  }

  /* This method updates the x and y coordinates every frame, as well as the velocity, making the ball effectively move. It also calls the
   handleBounce and handleMouse functions, checking constantly whether the bouncer has touched an edge of the screen or is being hovered over by
   the mouse. */

  void update() {
    x += vx;
    y += vy;

    handleBounce();
    handleMouse();
  }

  /* This method checks if the edge of the bouncer is touching the edge of the screen. If it is, it sets the velocity to negative,
   which makes it go in the opposite direction. */

  void handleBounce() { 
    // This checks if the bouncer is either touching the left or right side of the screen.
    if (x - size/2 < 0 || x + size/2 > width) {
      vx = -vx;
      // CHANGED : Every time the bouncer touches the left or right side of the screen, it randomly teleports it to a random X coordinate within 480.
      x = floor(random(480));
    }
    // This checks if the bouncer is either touching the top or bottom of the screen.
    if (y - size/2 < 0 || y + size/2 > height) {
      vy = -vy;
      // CHANGED : Every time the bouncer touches the top or bottom side of the screen, it randomly teleports it to a random Y coordinate within 240.
      y = floor(random(240));
    }

    // This constrains the bouncer's x and y position to the screen's height and width, making sure the edges don't go past it at all.

    x = constrain(x, size/2, width-size/2);
    y = constrain(y, size/2, height-size/2);
  }

  /* This method checks whether the mouse is hovering over the x and y coordinates of the bouncer. If it is, it fills the bouncer color to
   the color set if it's hovering. If not, it keeps it at the default color. */

  void handleMouse() {
    if (dist(mouseX, mouseY, x, y) < size/2) {
      fillColor = hoverColor;
    } else {
      fillColor = defaultColor;
    }
  }

  /* This method draws the bouncer as a circle, at the color specified. */

  void draw() {
    noStroke();
    fill(fillColor);
    ellipse(x, y, size, size);
  }
  
  /* CHANGED: Added a function to check whether the mouse is clicked. If it is, then it changes the size of the bouncer to random within 200. */

  void handleClick() {
    if (isMouseClicked == true) {
      size = floor(random(200));
    }
  }
}