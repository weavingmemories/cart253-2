/* The sky class will be a class that is generated to look 'soft' with either noise or changePixels
 function, and will be dynamic and change color based on what color it is seeing from the webcam
 from the video library. It will likely keep the same color for a certain amount of time to keep
 the calming vibe and not be chaotic.
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
    // This is where the sky will take the reading taken by update() and
    // will create a noise or changePixels sky using said color.
    tint(skyR, skyG, skyB);
    image(background, 0, 0);
  }
}