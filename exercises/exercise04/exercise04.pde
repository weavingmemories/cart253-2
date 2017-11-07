// Griddies
// by Pippin Barr
// MODIFIED BY: 
//
// A simple artificial life system on a grid. The "griddies" are squares that move
// around randomly, using energy to do so. They gain energy by overlapping with
// other griddies. If a griddie loses all its energy it dies.

// The size of a single grid element
int gridSize = 20;
// An array storing all the griddies
Griddie[] griddies = new Griddie[100];
Lipso[] lipsos = new Lipso[100];

// setup()
//
// Set up the window and the griddies

void setup() {
  // Set up the window size and framerate (lower so we can watch easier)
  size(640, 480);
  frameRate(10);

  // QUESTION: What does this for loop do?
  // This for loop initializes and creates the Griddies in the first place, making sure the amount never goes over the maximum array length for the Griddies (100).
  for (int i = 0; i < griddies.length; i++) {
    int x = floor(random(0, width/gridSize));
    int y = floor(random(0, height/gridSize));
    griddies[i] = new Griddie(x * gridSize, y * gridSize, gridSize);
  }

  for (int i = 0; i < lipsos.length; i++) {
    int x = floor(random(0, width/gridSize));
    int y = floor(random(0, height/gridSize));
    lipsos[i] = new Lipso(x * gridSize, y * gridSize, gridSize);
  }
}

// draw()
//
// Update all the griddies, check for collisions between them, display them.

void draw() {
  background(50);

  // We need to loop through all the griddies one by one
  for (int i = 0; i < griddies.length; i++) {

    // Update the griddies
    griddies[i].update();

    // Now go through all the griddies a second time...
    for (int j = 0; j < griddies.length; j++) {
      // QUESTION: What is this if-statement for?
      // This if statement checks whether the griddies have collided by checking if the j in the loop is the opposite of the already stated i.
      if (j != i) {
        // QUESTION: What does this line check?
        // This line checks if the griddies being checked in the loop are colliding with the ones being checked a second time.
        griddies[i].collide(griddies[j]);
      }
    }

    // Display the griddies
    griddies[i].display();
  }
  for (int i = 0; i < lipsos.length; i++) {

    // Update the lipsos
    lipsos[i].update();

    // Now go through all the lipsos a second time...
    for (int j = 0; j < lipsos.length; j++) {
      // This if statement checks whether the lipsos have collided by checking if the j in the loop is the opposite of the already stated i.
      if (j != i) {
        // This line checks if the griddies being checked in the loop are colliding with the ones being checked a second time.
        lipsos[i].collide(griddies[j]);
      }
      for (int k = 0; k < lipsos.length; k++) {
        // This if statement checks whether the lipsos have collided by checking if the j in the loop is the opposite of the already stated i.
        if (k != i) {
          // This line checks if the griddies being checked in the loop are colliding with the ones being checked a second time.
          lipsos[i].collide(lipsos[k]);
        }
      }

      // Display the griddies
      lipsos[i].display();
      
    }
  }
}