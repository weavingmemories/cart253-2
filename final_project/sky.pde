/* The sky class will be a class that is generated to look 'soft' with the noise
 function, and will change color based on what time it is (upon the sketch loading).
 */

int h = hour();
int skyR = 0;
int skyG = 0;
int skyB = 0;

class Sky {

  // Properties //
  PImage background;
  // Constructor //
  Sky() {
  }

  // Method //

  void update() {
    // This is where the sky will read the time displayed by the computer, once in setup,
    // and set the sky color.

    if (h >= 0 && h <= 5) {
      // dark night
      skyR = 32;
      skyG = 18;
      skyB = 58;
    }

    if (h >= 6 && h <= 8) {
      // sunrise
      skyR = 196;
      skyG = 78;
      skyB = 151;
    }

    if (h >= 9 && h <= 15) {
      // morning daylight
      skyR = 97;
      skyG = 188;
      skyB = 237;
    }

    if (h >= 16 && h <= 18) {
      // sunset
      skyR = 221;
      skyG = 93;
      skyB = 46;
    }

    if (h >= 19 && h <= 21) {
      // early evening
      skyR = 84;
      skyG = 47;
      skyB = 163;
    }

    if (h >= 22 && h <= 23 ) {
      // dark evening
      skyR = 24;
      skyG = 2;
      skyB = 48;
    }
    
    // This is where the Noise pixels are created. They are only created once, and saved into an image
    // which will then be tinted.

    noiseDetail(16, 0.6);
    for (int i = 0; i < width*height; i++) {
      float x = i % width;
      float y = (i / width);
      float n = noise(x/width, y/height);
      color c = color(n * 255);
      stroke(c);
      point(x, y);
    }
    loadPixels();
    background = get(0, 0, width, height);
    updatePixels();
  }

  void display() {
    // This is where the background created with noise will be tinted according to the time of day.
    tint(skyR, skyG, skyB);
    image(background, 0, 0);
  }
}