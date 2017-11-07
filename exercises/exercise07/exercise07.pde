import processing.sound.*;
import processing.video.*;

Rain r1;

// Adding a variable for video capture.
Capture video;

// Adding the variables for each background sound as a soundfile.

SoundFile rain;
SoundFile ambient;

// Somewhere to store our 5 sound files
SoundFile[] tones = new SoundFile[5];
// The number of frames per beat of music
int framesPerBeat = 15;

int numDrops = 40;
Rain[] drops = new Rain[numDrops]; // Declare and create the array

void setup() {
  size(600,600);
  background(0);
  
  // Adding video capture into the sketch.
  video = new Capture(this,640,480,30);
  video.start();
  
  // Each tone loaded into the program.
  
   // Go through the array loading sound files into it
  for (int i = 0; i < tones.length; i++) {
    // We can use the i variable to work out which filename to use!
    tones[i] = new SoundFile(this, "sound/tone0" + (i+1) + ".wav");
  }
  
  rain = new SoundFile(this, "sound/rain.mp3");
  ambient = new SoundFile(this, "sound/ambient.mp3");
  
  // Play the sounds as background noise.
  ambient.loop();
  rain.loop();
  
  smooth();
  noStroke();
  //Loop through array to create each object
  for (int i = 0; i < drops.length; i++) {

    drops[i] = new Rain(); // Create each object
    r1 = new Rain();
  }
}

void draw(){
  
  // Reading the webcam data
   if (video.available()) {
    video.read();
  }
  
  // Use modulo to check if this frame is a multiple of the beat count
  if (frameCount % framesPerBeat == 0) {
    // Pick a random index in the array
    int randomIndex = floor(random(0, tones.length));
    // Bonus! Set the pan of the sound based on the mouse!
    // -1 means full left, 1 means full right
    tones[randomIndex].pan(map(mouseX,0,width,-1,1));
    // Bonus! Set the amplitude of the sound based on the mouse!
    tones[randomIndex].amp(map(mouseY,0,height,1,0));
    // Play the sound
    tones[randomIndex].play();
  }
  
  // Captures the brightness of what is being displayed in the webcam
  int brightness = 0;
  for ( int x = 1; x < video.width; x++ ) {
    for ( int y = 0; y < video.height; y++ ) {
      int loc = x + y * width;
      brightness += brightness(video.pixels[loc]);
    }
  }
 
  // Changes the background of the screen to the average brightness value.
  float averageBrightness = brightness/(video.width*video.height);
  fill(averageBrightness,80);
  rect(0,0,600,600);
  //Loop through array to use objects.
  for (int i = 0; i < drops.length; i++) {
    drops[i].fall();
  }

}