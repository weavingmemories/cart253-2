/*

 SNOWFLAKES by Macey McCormick
 
 This program is less of a game and more of an interactive experience. I've always been very interested in
 installation art and projects that respond to the user in an aesthetic way, as it sort of feels like a 
 "magical" experience. I wanted to emulate that with this program, which is a custom experience based on time
 and viewer interaction.
 
 Covering 3D objects, rotations and manipulations of them was one of my inspirations, as well as learning about
 the wide variety of libraries. I enjoyed integrating that into the generative snowflakes, as well as working with
 noise() to generate a slightly different background every time the program runs. I wanted it to be not too ambitious
 an undertaking, but to still be personal and slightly unique every time it loaded. I'm mostly proud of working with
 multiple levels of interactivity- motion detection to make the snowflakes bluster across the screen, as well as
 mousing over them to add to the soundscape and create a melody. Just watching them is soothing, but it adds a layer
 of control for the viewer to be able to change the outcome.
 
 */

import processing.sound.*;
import processing.video.*;

//SoundFile background;
Capture video; 

/*
 import the libraries
 create global variables for the sky class
 create global variables for the snowflake class
 */

// Previous Frame
PImage prevFrame;
// How different must a pixel be to be a "motion" pixel
float threshold = 50;  

// This boolean detects whether there is motion in the frame or not.
boolean isMoving;
int stillFrames = 0;

// Inserts the soundfiles to play during the sketch.
SoundFile bgm;



Sky sky = new Sky();
SoundFile[] tones = new SoundFile[5];
Snowflake[] snowflakes = new Snowflake[50];



void setup() {
  /*
  1. set up the screen size
   2. create the sky class
   3. create the snowflakes class
   4. load the video library
   5. load the weather library
   6. load the sound library
   */
  size(1900, 1000, P3D);


  bgm = new SoundFile(this, "sounds/bgmusic.mp3");

  video = new Capture(this, 320, 240, 30);
  prevFrame = createImage(video.width, video.height, RGB);
  video.start();
  bgm.loop();


  sky.update();

  // This loads all of the soundfile tones into an array, organizing them.

  for (int i = 0; i < tones.length; i++) {
    tones[i] = new SoundFile(this, "sounds/tone0" + (i+1) + ".wav");
  }

  // This loads all of the snowflakes in the array at once, creating 50 snowflakes that will
  // spawn at a random location on the x-axis and at the top of the screen, with random
  // sizes up to 100 and line thicknesses up to 5.

  for (int i = 0; i < snowflakes.length; i++) {
    SoundFile randomTone = tones[floor(random(tones.length))];
    snowflakes[i] = new Snowflake(floor(random(width)), floor(random(height)), 2, 2, floor(random(100)), floor(random(5)), randomTone);
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
  // println(totalMotion);
  if (avgMotion >=20) {
    isMoving = true;
    stillFrames = 30;
  } else {
    stillFrames--;
    if (stillFrames == 0) {
      isMoving = false;
    }
  }
  for (int i = 0; i < snowflakes.length; i++) {
    snowflakes[i].update();
    snowflakes[i].display();
    snowflakes[i].isOffScreen();
    snowflakes[i].mouseOver();
  }

  sky.display();
}