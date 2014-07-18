/* Processing Monster      By: Antonio Lee
 
 This is a processing monster about a computer which has a virus.
 It exploits the fear of people and their fears with computer's and
 technology. Everytime you click a new virus monster eye ball appears. 
 If you press the mouse button too much, a ball of virus's explodes and
 starts to multiply. Once there are a bunch of virus monsters on the 
 virtual screen, they explode out of the screen and start to to 
 bounce everywhere in the virtual environment. If you let the program run
 long enough, it will eventually crash because the program enters an
 endless loop where the virus monsters keep coming.
 
 
 Instructions:
 1. Keep clicking.
 2. Be suprised.
 3. Don't Press 'a' (adds monster balls)
 4. If your experiencing trouble Press 'x' to exit
 5. Press 'r' to remove all balls. 
 
 */


//Set Global Variables
ArrayList balls;
float gravity = .1;
float drag = 0.99;

int YBoundTop = 170;
int LXBound = 165;
int RXBound = 565;
int YBound = 385;
int ballCount = 0;
int boundsCount = 0;
int numBalls = 5;

boolean allballs = false;
boolean restart = false;

void setup() {
  size(800, 600);              
  balls = new ArrayList();  //Declare balls as an ArrayList and add one ball to the list with random(x,y,xVel,yVel,diam)
  balls.add(new Ball(random(175, 550), 200, random(-1, 1), random(-1, 1), (int)random(5, 30)));
  frameRate(60);
}

void draw() {
  int sec = second();
  background(255); // set background to white
  rectMode(CORNERS);  // set rectMode to corners instead of x,y,width,height
  strokeWeight(12);    // set thickness to 12 px
  strokeCap(ROUND);    // set lines to have rounded ends

  //Monitor
  fill(255); 
  stroke(0);  // color for lines are black
  line(118, 120, 200, 40);    
  line(198, 40, 690, 40);      // Hard Coded the lines that make the monitor
  line(618, 120, 687, 40);     // look 3 Dimensional
  line(690, 40, 690, 370);    
  line(623, 440, 690, 370);
  rect(120, 120, 620, 440);  // Outside shell Rectangle
  fill(25);                 // Gray-ish computer screen
  rect(160, 170, 570, 390); // The actual screen rectangle
  fill(255); 

  //Keyboard
  rect(60, 480, 560, 580);    //Outside
  strokeWeight(6);
  rect(80, 500, 540, 560);    //Inside

  // Mouse
  pushMatrix();                        // push matrix onto matrix stack
  rotate(PI/31);                       // This is so the rotate effect 
  arc(730, 300, 300, 300, 0, PI/2);    // is only effecting the arc
  popMatrix();                         // pop back to original matrix
  strokeWeight(8);
  ellipse(650, 530, 80, 100);        // The actual mouse
  if (mousePressed) {                // if the mouse is pressed,
    fill(0);                         // then the left mouse will light
  }
  arc(650, 530, 80, 100, PI, TWO_PI-PI/2);  // mouse button
  fill(255);
  strokeWeight(1);
                                                  // for loop, cycles through all balls in the array 
  for (int i = balls.size()-1; i >= 0; i--) {    // list and performs the update and draw functions.
    Ball ball = (Ball) balls.get(i);            // An ArrayList doesn't know what it is storing so we have 
    ball.update();                             // to cast the object coming out; i.e the -> (Ball) in front of
    ball.draw();                              //                                                 balls.get(i)

    if (restart == true) {
      balls.remove(i);
    }
    
    if(balls.size() <= 1 ){
      restart = false;
    }
  }
  
  if (ballCount >= 15) {              // If you create more than 15 balls,
    theBalls();                      // all hell will break loose
  }

  if (allballs == true) {          // after the balls start popping out, 
    if (sec % 3 == 0) {            // every 3 seconds, boundscount will 
      boundsCount++;               // increment by 1 and call the function
      theBalls();                  // theBalls which adds balls
    }                              
  }

  if (keyPressed) {                // Call the function, theBalls(), by pressing 'a'
    if (key == 'a') {
      theBalls();
    }

    if (key == 'r') {              // by pressing 'r'
      restart = true;              // set boolean restart == true
      reset();                     // call the function, reset()
    } 

    if (key == 'x') {              // You can exit the program by pressing 'x'
      exit();
    }
  }
  
  if(boundsCount >= 30){          // once bounds count is at 60
    breakBounds();                // call the function breakBounds
    numBalls = 15;                // and set the number of balls spawned to 15
  }

  //For debugging purposes
  print(mouseX+" ");
  print(mouseY+" ");
  print(boundsCount);
  println();
}

// Function, everytime the mouse button is released
// a new ball is added to the list
void mouseReleased() {
  balls.add(new Ball(random(175, 550), 200, random(-2, 2), random(1, 2), (int)random(5, 30)));
  ballCount++;
}

// Function which will cause the bounds to change and a lot
// of balls to rain down everywhere

void theBalls() {
  allballs = true;
  strokeWeight(1);
  for (int i = 1;i<numBalls;i++) {
    balls.add(new Ball(width/2, height/2, random(-12, 12), random(-12, 12), (int)random(5, 45)));
  }
}

void breakBounds(){    // This function will break the bounds of the balls
  YBoundTop = 0;      // from bouncing inside the computer monitor 
  YBound = height;   
  LXBound = 0;
  RXBound = width;   
  gravity = 0;        // Also sets gravity == 0
  drag = 0;           // and drag == 0, to stop simulated physics
}

void reset() {           // This function when called will
  gravity = .1;          // restore all global variables
  drag = 0.99;           // to there original settings.
  YBoundTop = 165;       // 
  LXBound = 160;         // This is so that the balls will stay
  RXBound = 570;         // inside the screen instead of flyinh
  YBound = 390;          // all over the place
  ballCount = 0;
  boundsCount = 0;
  allballs = false;
}

