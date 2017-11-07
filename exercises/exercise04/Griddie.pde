// Griddie
//
// A class defining the behaviour of a single Griddie
// which can move randomly in the window (within the grid),
// loses energy per move, and gains energy from overlapping
// with another Griddie.



class Griddie {
  // Limits for energy level and gains/losses
  int maxEnergy = 255;
  int moveEnergy = -1;
  int collideEnergy = 10;

  // Position, size, energy, and fill color
  int x;
  int y;
  int size;
  int energy;
  color fill = color(255, 0, 0);

  // Griddie(tempX, tempY, tempSize)
  //
  // Set up the Griddie with the specified location and size
  // Initialise energy to the maximum
  Griddie(int tempX, int tempY, int tempSize) {
    x = tempX;
    y = tempY;
    size = tempSize;
    energy = maxEnergy;
  }

  // update()
  //
  // Move the Griddie and update its energy levels
  void update() {

    // QUESTION: What is this if-statement for?
    // This if-statement checks if the Griddie's energy level is 0. If it is, it returns the value, effectively 'killing' the Griddie.
    if (energy == 0) {
      return;
    }

    if (isTouchingGriddie == true)
    {
      energy -= collideEnergy;
    }

    // QUESTION: How does the Griddie movement updating work?
    // The movement updating works by moving the X and Y positions to be random in either direction,
    // but they take the size of the Griddie into account, so it can only move its size space away from
    // itself, making the illusion of a grid.
    int xMoveType = floor(random(-1, 2));
    int yMoveType = floor(random(-1, 2));
    x += size * xMoveType;
    y += size * yMoveType;

    // QUESTION: What are these if statements doing?
    // These if statements are constraining the Griddies to the height and width of the screen,
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

    // Update the Griddie's energy
    // Note that moveEnergy is negative, so this _loses_ energy
    energy += moveEnergy;

    // Constrain the Griddies energy level to be within the defined bounds
    energy = constrain(energy, 0, maxEnergy);
  }

  // collide(other)
  //
  // Checks for collision with the other Griddie
  // and updates energy level

  void collide(Griddie other) {
    // QUESTION: What is this if-statement for?
    // This if-statement checks if the two Griddies have 0 energy while colliding (making them entirely faded out)
    // If so, return the value and make sure the program knows the Griddie's energy is returned as 0.
    if (energy == 0 || other.energy == 0) {
      return;
    }

    // QUESTION: What does this if-statement check?
    // This if-statement checks if the x or y position of a Griddie is the same as another, thus making them collide.
    if (x == other.x && y == other.y) {
      // Increase this Griddie's energy
      energy += collideEnergy;
      // Constrain the energy level to be within bounds
      energy = constrain(energy, 0, maxEnergy);
    }
  }

  // display()
  //
  // Draw the Griddie on the screen as a rectangle
  void display() {
    // QUESTION: What does this fill line do?
    // This fill line fills the Griddies with the colors 'fill' and 'energy',
    // which are red and alpha (energy works as alpha simultaneously, so the lower the number,
    // the lower the alpha AND energy.
    fill(fill, energy); 
    noStroke();
    rect(x, y, size, size);
  }
}