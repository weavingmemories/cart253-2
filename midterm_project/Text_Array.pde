class TextArray {

  // Creates two new strings, one for depression and one for anxiety.
  String[] depressionText = new String[10];
  String[] anxietyText = new String[10];

  int textMargin = 100;
  int numberToCallDepText = floor(random(depressionText.length));
  int numberToCallAnxText = floor(random(anxietyText.length));
  boolean isTextDisplayed = false;
  float textAlpha = 255;
  float posX = random(width/2-100, width/2+100);
  float posY = random(height/2-100, height/2+100);
  float depTextSize = random(25, 35);

  TextArray() {

    // Wrote down text from myself and others when asked to give statements/questions they've faced during depression.
    depressionText[0] = "There's no \npoint anyway";
    depressionText[1] = "I'm so tired";
    depressionText[2] = "I wish I \ndidn't exist";
    depressionText[3] = "No one actually \nlikes me anyway";
    depressionText[4] = "I'm too tired to \npretend to be happy";
    depressionText[5] = "What's the point?";
    depressionText[6] = "I don't really care";
    depressionText[7] = "I don't think I can \ndo this anymore";
    depressionText[8] = "Everyone would be better \noff without me";
    depressionText[9] = "";

    // Wrote down text from myself and others when asked to give statements/questions they've faced during anxiety.
    anxietyText[0] = "I can't do this";
    anxietyText[1] = "What if I fail?";
    anxietyText[2] = "Do you hate me?";
    anxietyText[3] = "I can't do anything right";
    anxietyText[4] = "This is never gonna work, it never does";
    anxietyText[5] = "Are they just using me?";
    anxietyText[6] = "I feel sick";
    anxietyText[7] = "I can't, I can't, I can't";
    anxietyText[8] = "Are they making fun of me?";
    anxietyText[9] = "";
  }

  // Displays text from the depressionText array at a randomized point on the screen, near the center.
  void depressionDisplay() {
    textAlign(CENTER);
    fill(255, textAlpha);
    textSize(depTextSize);
    text(depressionText[numberToCallDepText], posX, posY);
    isTextDisplayed = true;
    if (isTextDisplayed == true) {
      if (textAlpha <= 0) {
        isTextDisplayed = false;
        textAlpha = 255;
        posX = random(width/2-textMargin, width/2+textMargin);
        posY = random(height/2-textMargin, height/2+textMargin);
        depTextSize = random(25, 35);
        numberToCallDepText = floor(random(depressionText.length));
      }
      textAlpha--;
    }
  }

  // Displays text from the anxietyText array at a randomized point on the screen, near the center.
  void anxietyDisplay() {
    textAlign(CENTER);
    fill(random(255));
    textSize(random(15, 30));
    text(anxietyText[numberToCallAnxText], random(width/2-100, width/2+100), random(height/2-textMargin, height/2+textMargin));
    numberToCallAnxText = floor(random(anxietyText.length));
  }
}