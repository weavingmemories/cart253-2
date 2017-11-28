import processing.video.*;

Capture video; 

/*
  import the libraries
 create global variables for the sky class
 create global variables for the snowflake class
 create global variables for the sound class
 */

// Previous Frame
PImage prevFrame;
// How different must a pixel be to be a "motion" pixel
float threshold = 50;  

// This boolean detects whether there is motion in the frame or not.
boolean isMoving;
int stillFrames = 0;

Sky sky = new Sky();
Snowflake[] snowflakes = new Snowflake[50];


void setup() {
  /*
  1. set up the screen size
   2. create the sky class
   3. create the snowflakes class
   4. create the sound class
   5. load the video library
   6. load the weather library
   7. load the sound library
   */
  size(1900, 1000, P3D);

  video = new Capture(this, 320, 240, 30);
  prevFrame = createImage(video.width, video.height, RGB);
  video.start();
  
  
   sky.update();



  // This loads all of the snowflakes in the array at once, creating 50 snowflakes that will
  // spawn at a random location on the x-axis and at the top of the screen, with random
  // sizes up to 100 and line thicknesses up to 5.

  for (int i = 0; i < snowflakes.length; i++) {
    snowflakes[i] = new Snowflake(floor(random(width)), floor(random(height)), 2, 2, floor(random(100)), floor(random(5)));
  }
}

void draw() {
  
  /*
  1. read video feed
   2. read weather library
   3. update the sound
   / play the sound
   4. update the sky
   / display the sky
   5. update the snowflakes
   / display the snowflakes
   */

  // Capture video
  if (video.available()) {
    // Save previous frame for motion detection!!
    prevFrame.copy(video, 0, 0, video.width, video.height, 0, 0, video.width, video.height);
    prevFrame.updatePixels();
    video.read();
  }

  loadPixels();
  video.loadPixels();
  prevFrame.loadPixels(); 

  // Begin loop to walk through every pixel
  // Start with a total of 0
  float totalMotion = 0;
  // Sum the brightness of each pixel
  for (int i = 0; i < video.pixels.length; i++) {               
    color current = video.pixels[i];
    // Step 2, what is the current color
    color previous = prevFrame.pixels[i];
    // Step 3, what is the previous color 
    // Step 4, compare colors (previous vs. current)
    float r1 = red(current);
    float g1 = green(current);
    float b1 = blue(current);
    float r2 = red(previous);
    float g2 = green(previous);
    float b2 = blue(previous);

    float diff = dist(r1, g1, b1, r2, g2, b2);

    totalMotion += diff;
  }

  float avgMotion = totalMotion / video.pixels.length;
  println(totalMotion);
  if (avgMotion >=20) {
    isMoving = true;
    stillFrames = 30;
    //  println("I'm Moving!");
  } else {
    stillFrames--;
    if (stillFrames == 0) {
      isMoving = false;
    }
    //   println("I'm Still");
  }
  for (int i = 0; i < snowflakes.length; i++) {
    snowflakes[i].update();
    snowflakes[i].display();
    snowflakes[i].isOffScreen();
  }

   sky.display();

}