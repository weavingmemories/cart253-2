/* This sketch creates two 'bouncers' which are balls, which move slowly across the screen and bounce every time they collide with an edge
of the screen. They leave a trail behind them, red and blue respectively, and because they are not full opacity, look soft at the edges. 
When the mouse hovers over the beginning of the trail, it becomes a slightly brighter color as long as it is hovered over. */

// This section declares the background color as a faded pink, as well as declares there will be two Bouncer classes, defining them as separate.

color backgroundColor = color(200,150,150);
Bouncer bouncer;
Bouncer bouncer2;

/* This function sets up the screen size to 640x480 pixels, sets the background to the previously declared background color, and sets up the two
bouncers(balls), specifying their x and y positions on the screen, their velocity, their size, their default color,
and color when hovered over by the mouse. */

void setup() {
  size(640,480);
  background(backgroundColor);
  bouncer = new Bouncer(width/2,height/2,2,2,50,color(150,0,0,50),color(255,0,0,50));
  bouncer2 = new Bouncer(width/2,height/2,-2,2,50,color(0,0,150,50),color(0,0,255,50));
}

/* This function calls the bouncers (balls) and tells them to continuously update their position and velocity every frame, as well as draw
them in their new position every frame.
*/

void draw() {
  bouncer.update();
  bouncer2.update();
  bouncer.draw();
  bouncer2.draw();
}

// CHANGED: Checked when the mouse is clicked, and sends the 'true' boolean back to the Bouncer class.

void mouseClicked() {
  bouncer.isMouseClicked = true;
  bouncer.handleClick();
  bouncer2.isMouseClicked = true;
  bouncer2.handleClick();
}