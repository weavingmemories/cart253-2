import processing.sound.*;
import processing.video.*;

Rain r1;

// Adding a variable for video capture.
Capture video;

// Adding the variables for each background sound as a soundfile.

SoundFile rain;
SoundFile ambient;
SoundFile tone1;
SoundFile tone2;
SoundFile tone3;
SoundFile tone4;
SoundFile tone5;

String tonePattern = "1-2-3";

// Somewhere to store our 5 wave frequencies
int[] frequencies = new int[5];

// Track which character we're playing
int currentToneBeat = 0;

// The number of frames per beat of music
int framesPerBeat = 10;
int framesPerToneBeat = 20;

int numDrops = 40;
Rain[] drops = new Rain[numDrops]; // Declare and create the array

void setup() {
  size(600,600);
  background(0);
  
  // Adding video capture into the sketch.
  video = new Capture(this,640,480,30);
  video.start();
  
  rain = new SoundFile(this, "sound/rain.mp3");
  ambient = new SoundFile(this, "sound/ambient.mp3");
  
  // Play the sounds as background noise.
  ambient.loop();
  rain.loop();
  
  // Add our other tone files
  tone1 = new SoundFile(this,"sound/tone01.wav");
  tone2 = new SoundFile(this,"sound/tone02.wav");
  tone3 = new SoundFile(this,"sound/tone03.wav");
  tone4 = new SoundFile(this,"sound/tone04.wav");
  tone5 = new SoundFile(this,"sound/tone05.wav");
  
  // Go through the array loading frequencies into it
  for (int i = 0; i < frequencies.length; i++) {
    // We can use the i variable to set up equidistant frequencies
    frequencies[i] = 110 + (i * 55);
  
  smooth();
  noStroke();
  //Loop through array to create each object
  for (int k = 0; k < drops.length; k++) {

    drops[k] = new Rain(); // Create each object
    r1 = new Rain();
  }
}
}

void draw(){
  
  // Reading the webcam data
   if (video.available()) {
    video.read();
  }
 
  // Use modulo to check if this frame is a drum beat frame
  if (frameCount % framesPerToneBeat == 0) {
    // Check whether the current point in the drum pattern is a kick
    // or a snare and play them if so
     if (tonePattern.charAt(currentToneBeat) == '1') {
        tone1.play();
     }
     if (tonePattern.charAt(currentToneBeat) == '2') {
        tone2.play();
     }
     if (tonePattern.charAt(currentToneBeat) == '3') {
        tone3.play();
     }
     if (tonePattern.charAt(currentToneBeat) == '4') {
        tone4.play();
     }
     if (tonePattern.charAt(currentToneBeat) == '5') {
        tone5.play();
     }
     // Increment the drum beat (and loop back to the start if finished)
     currentToneBeat = (currentToneBeat + 1) % tonePattern.length();
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