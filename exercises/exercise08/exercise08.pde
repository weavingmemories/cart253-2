/*
  import the libraries
  create global variables for the sky class
  create global variables for the snowflake class
  create global variables for the sound class
*/

Snowflake snowflake;

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
  size(1900,1000);
    snowflake = new Snowflake(5,5,5);
   
  }

void draw() {
  background(255);
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
  snowflake.display();
}