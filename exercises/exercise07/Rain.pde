class Rain {
  float r = random(600);
  float y = random(-height);

  void fall() {
    y = y + random(7);
    fill(255);
    ellipse(r, y, random(5,10), random(5,10));

   if(y>height){
   r = random(600);
   y = random(-200);
   }

  }
}