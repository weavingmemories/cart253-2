/* The snowflake class will procedurally generate snowflakes with varying shapes and sizes
   every time, with a 'fall' method that will work with a sin/cos/tan wave- changes of the
   intensity of the wave based on motion detection and the amount of snowflakes based on
   the temperature displayed by Yahoo Weather. They will rotate on a 3D axis.
*/

class Snowflakes {
  
  // Properties //
  
  // This is where the snowflakes will have a determined x and y,
  // velocity, speed, and size.
  
  // Constructor //
  Snowflakes() {
    // This would be where they are procedurally generated?
  }
  
  // Method //
  
  void update() {
    // This will be where the snowflakes animate!
    // They will be falling down the screen, updating their y position based on SPEED
    // and their x position based on the sin/cos/tan wave MOTION DETECTION.
    // They will also be rotating on a 3D axis.
    // The number of snowflakes will change based on the TEMPERATURE reading.
    
    /* So, first:
       1. Check the temperature reading.
          (Change the number for amount of snowflakes based off of that)
       2. Check the wind velocity.
          (Change the SPEED based off of the wind velocity)
          (Update the y position)
       3. Check the motion detection.
          (Change the number for sin/cos/tan wave based off of that)
          (Update the x position)
       4. Update the rotation
    */
    
  }
  
  void display() {
    // This is where we draw the snowflakes every frame with the updated coordinates.
    
  }
}