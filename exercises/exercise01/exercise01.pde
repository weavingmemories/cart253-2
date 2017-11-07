final int CIRCLE_SPEED = 7; // Integer variable that signifies the speed of the circle is set to 7. Can't be changed.
int STROKE_WEIGHT = 5; // CHANGED: Integer variable that signifies the stroke weight of the circle, is set to 5.
final color NO_CLICK_FILL_COLOR = color(250, 100, 100); // Color variable that signifies the color of the circle when the distance between mouse and circle is greater than 25 (salmon/darker pink). Can't be changed.
final color CLICK_FILL_COLOR = color(100, 100, 250); // Color variable that signifies the color of the circle when the distance between mouse and circle is less than 25 (lightish blue with a hint of purple). Can't be changed.
final color BACKGROUND_COLOR = color(250, 150, 150); // Color variable that signifies the background color (light pink). Can't be changed.
final color STROKE_COLOR = color(250, 150, 150); // Color variable that signifies the stroke (outline) of the circle (light pink). Can't be changed.
final int CIRCLE_SIZE = 50; // Integer variable that signifies the size of the circle and clarifies the value 50 is set within. Can't be changed.

int circleX; // Creates a variable for circle's x coordinate (position on the screen on the x-axis)
int circleY; // Creates a variable for circle's y coordinate (position on the screen on the y-axis)
int circleVX; // Creates a variable for circle's velocity on the x-axis
int circleVY; // Creates a variable for circle's velocity on the y-axis

void setup() {
  size(640, 480); // Sets the size of the screen to 640 x 480 pixels.
  circleX = width/2; // Sets the circle's x coordinate to half of the width of the screen, thereby putting it in the center horizontally.
  circleY = height/2; // Sets the circle's y coordinate to half of the height of the screen, thereby putting it in the center vertically.
  circleVX = CIRCLE_SPEED; // Sets the circle's velocity along the x-axis to equal the speed of the circle.
  circleVY = CIRCLE_SPEED; // Sets the circle's velocity along the y-axis to equal the speed of the circle.
  stroke(STROKE_COLOR); // Sets the stroke of the circle to the previously defined variable STROKE_COLOR (pink)
  fill(NO_CLICK_FILL_COLOR); // Sets the fill of the circle to the previously defined variable NO_CLICK_FILL_COLOR (salmon/darker pink).
  background(BACKGROUND_COLOR); // Sets the background color to the previously defined variable BACKGROUND_COLOR (light pink).
}

void draw() {
  println(STROKE_WEIGHT); // CHANGED: Printing the variable stored in STROKE_WEIGHT to keep an eye on it.
  if (STROKE_WEIGHT >= 200) { // CHANGED: If the STROKE_WEIGHT variable is greater than or equal to 200-
    STROKE_WEIGHT = 200; // CHANGED: Keep at at 200. This effectively doesn't let it get higher than 200.
  }
  if (STROKE_WEIGHT <= 0) { // CHANGED: If the STROKE_WEIGHT variable is less than or equal to 0-
    STROKE_WEIGHT = 0; // CHANGED: Keep it at 0. This effectively doesn't let it get lower than 0.
  }
  
  strokeWeight(abs(STROKE_WEIGHT)); // CHANGED: Sets the stroke weight (thickness) to our previously defined variable STROKE_WEIGHT
  
    if (dist(mouseX, mouseY, circleX, circleY) < CIRCLE_SIZE/2) { // If the distance between the mouse's position on x-axis and y-axis and the circle's position on the x-axis and y-axis is less than the circle's size divided by two (25)
    fill(CLICK_FILL_COLOR); // Fill the circle with the color stored in CLICK_FILL_COLOR (lightish blue with a hint of purple).
  }
  else { // If this condition is not true,
    fill(NO_CLICK_FILL_COLOR); // Fill the circle with the color stored in NO_CLICK_FILL_COLOR (which would keep it as salmon/darker pink).
  }
  
    if (mouseX > 320 || mouseY > 240) { // CHANGED: If the mouse's position on the X-axis is greater than 320, OR if the mouse's position on the Y-axis is greater than 240,
      STROKE_WEIGHT++; // CHANGED: Increase the value stored in STROKE_WEIGHT by 1 per frame.
    }
    else { // CHANGED: Otherwise,
      STROKE_WEIGHT--; // CHANGED: Decrease the value stored in STROKE_WEIGHT by 1 per frame.
    }
    
  ellipse(circleX, circleY, CIRCLE_SIZE, CIRCLE_SIZE); // Draw an ellipse placed at the previously stated circleX and circleY coordinates (center of the screen), making it the size of the value stored within CIRCLE_SIZE (50) making it 50 pixels by 50 pixels.
  circleX += circleVX; // The circleX variable is increased by the circleVX variable (which is set to CIRCLE_SPEED which is 7).
  circleY += circleVY; // The circleY variable is increased by the circleVY variable (which is set to CIRCLE_SPEED which is 7).
  if (circleX + CIRCLE_SIZE/2 > width || circleX - CIRCLE_SIZE/2 < 0) { // If the circle's position on the screen on the x-axis added with the size divided by 2 (25) is greater than the width of the canvas or opposite (if the edge of the circle touches an edge of the screen)
    circleVX = -circleVX; // begin to reduce the circleVX variable (circle's velocity along the x-axis, making it go the opposite direction and giving it a 'bounce' effect
  }
  if (circleY + CIRCLE_SIZE/2 > height || circleY - CIRCLE_SIZE/2 < 0) { // If the circle's position on the screen on the y-axis added with the size divided by 2 (25) is greater than the height of the canvas or opposite (if the edge of the circle touches an edge of the screen)
    circleVY = -circleVY; // begin to reduce the circleVY variable (circle's velocity along the y-axis, making it go the opposite direction and giving it a 'bounce' effect
  }
}

void mousePressed() { // When the mouse is pressed down,
  background(BACKGROUND_COLOR); // Change the background to the value stored in BACKGROUND_COLOR (light pink). Likely clears the screen.
}

void keyPressed() { // CHANGED: When any key is pressed, 
    fill(random(255), random(255), random(255)); // CHANGED: The color of the text will be completely random across RGB values
    textSize(random(100)); // CHANGED: The text size will be completely random from 0-99
    text("<3", mouseX, mouseY); // CHANGED: The text will say "<3", and be positioned at the mouse's position on the x and y axis.
  }