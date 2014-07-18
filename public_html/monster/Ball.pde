class Ball {
  float x, y, xVel, yVel;
  int diam;
  float eyeSize = random(1,7);
  
  Ball(float xStart, float yStart, float xV, float yV, int diameter) {
    x = xStart;
    y = yStart;
    xVel = xV;
    yVel = yV;
    diam = diameter;
  }

  void update() {
    // check if ball hit the bottom of the screen, if so need to reverse the velocity
    if (y > YBound-diam/2 || y < YBoundTop+diam/2) {
      yVel = -yVel;
    }
    // check if ball hit the side of the screen to reverse velocity if needed
    if (x > RXBound-diam/2 || x <LXBound+diam/2 ) {
      xVel = -xVel;
    }
      
    // adjust position based on velocity
    y = y + yVel;
    x = x + xVel;

    if(allballs == false){
    // adjust the velocity - increasing due to gravity
    yVel = yVel + gravity; // always accelerate down

    //  add some drag
    yVel = yVel*drag;
    }

  }

  void draw() {
    // draw the ball monster
    fill(255);
    strokeWeight(3);
    ellipse(x, y, diam, diam);
    fill(random(255));
    strokeWeight(2);
    ellipse(x, y, eyeSize, eyeSize);
    fill(255);
  }
}
  

