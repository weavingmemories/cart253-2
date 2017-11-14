/*
  import the libraries
 create global variables for the sky class
 create global variables for the snowflake class
 create global variables for the sound class
 */

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
  size(1900, 1000);

  for (int i = 0; i < snowflakes.length; i++) {
    snowflakes[i] = new Snowflake(floor(random(width)), floor(random(height)), floor(random(100)), floor(random(5)));
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
  background(0);

  for (int i = 0; i < snowflakes.length; i++) {
    snowflakes[i].display();
  }
}