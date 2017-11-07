// Lipso
//
// A class defining the behaviour of a single Lipso
// which can move randomly in the window (within the grid),
// loses energy per move, and gains energy from overlapping
// with a Griddie and stealing their energy. Lipsos are very
// parasitic and cannot gain energy from each other, instead
// fighting when they come into contact.

// Boolean variable to detect if the Lipso has collided with a Griddie
boolean isTouchingGriddie = false;

class Lipso {
  // Limits for energy level and gains/losses
  int maxEnergy = 255;
  int moveEnergy = -1;
  int collideEnergy = 10;

  // Position, size, energy, and fill color
  int x;
  int y;
  int size;
  int energy;
  color fill = color(0, 0, 255);

  // Lipso(tempX, tempY, tempSize)
  //
  // Set up the Lipso with the specified location and size
  // Initialise energy to the maximum
  Lipso(int tempX, int tempY, int tempSize) {
    x = tempX;
    y = tempY;
    size = tempSize;
    energy = maxEnergy;
  }

  // update()
  //
  // Move the Lipso and update its energy levels
  void update() {

    // QUESTION: What is this if-statement for?
    // This if-statement checks if the Lipso's energy level is 0. If it is, it returns the value, effectively 'killing' the Lipso.
    if (energy == 0) {
      return;
    }

    // QUESTION: How does the Lipso movement updating work?
    // The movement updating works by moving the X and Y positions to be random in either direction,
    // but they take the size of the Lipso into account, so it can only move its size space away from
    // itself, making the illusion of a grid.
    int xMoveType = floor(random(-1, 2));
    int yMoveType = floor(random(-1, 2));
    x += size * xMoveType;
    y += size * yMoveType;

    // QUESTION: What are these if statements doing?
    // These if statements are constraining the Lipsos to the height and width of the screen,
    // causing them to move in the opposite direction when they reach a wall. (e.g. if they touch the top,
    // they will move down, etc.)
    if (x < 0) {
      x += width;
    } else if (x >= width) {
      x -= width;
    }
    if (y < 0) {
      y += height;
    } else if (y >= height) {
      y -= height;
    }

    // Update the Lipso's energy
    // Note that moveEnergy is negative, so this _loses_ energy
    energy += moveEnergy;

    // Constrain the Lipsos energy level to be within the defined bounds
    energy = constrain(energy, 0, maxEnergy);
  }

  // collide(other)
  //
  // Checks for collision with the other species
  // and updates energy level

  void collide(Griddie other) {
    // This if-statement checks if the two Lipsos have 0 energy while colliding (making them entirely faded out)
    // If so, return the value and make sure the program knows the Lipso's energy is returned as 0.
    if (energy == 0 || other.energy == 0) {
      return;
    }

    // This if-statement checks if the x or y position of a Lipso is the same as another, thus making them collide.
    if (x == other.x && y == other.y) {
      // Increase this Lipso's energy
      energy += collideEnergy;

      // Send a variable to decrease the Griddie's energy
      isTouchingGriddie = true;

      // Constrain the energy level to be within bounds
      energy = constrain(energy, 0, maxEnergy);
    } else {
      isTouchingGriddie = false;
    }
  }

  void collide(Lipso other) {
    // This if-statement checks if the two Lipsos have 0 energy while colliding (making them entirely faded out)
    // If so, return the value and make sure the program knows the Lipso's energy is returned as 0.
    if (energy == 0 || other.energy == 0) {
      return;
    }

    // This if-statement checks if the x or y position of a Lipso is the same as another, thus making them collide.
    if (x == other.x && y == other.y) {
      // Decrease this Lipso's energy
      energy -= collideEnergy;


      // Constrain the energy level to be within bounds
      energy = constrain(energy, 0, maxEnergy);
    }
  }

  // display()
  //
  // Draw the Lipso on the screen as a rectangle
  void display() {
    // This fill line fills the Lipsos with the colors 'fill' and 'energy',
    // which are red and alpha (energy works as alpha simultaneously, so the lower the number,
    // the lower the alpha AND energy.
    fill(fill, energy); 
    noStroke();
    ellipse(x, y, size, size);
  }
}