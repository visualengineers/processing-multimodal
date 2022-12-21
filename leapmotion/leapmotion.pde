import com.leapmotion.leap.*;

Controller controller = new Controller();

void setup(){
  size( 800, 600 );
}

void draw(){
  background(0);
  
  // Get the most recent frame from the Leap Motion
  Frame frame = controller.frame();
  fill(255);
  text(frame.hands().count() + " Hands", 50, 50);
  text(frame.fingers().count() + " Fingers", 50, 100);
  
  // Get the list of fingers in the frame
  FingerList fingers = frame.fingers();

  // Iterate through the list of fingers
  for (Finger finger : fingers) {
    fill(255);
    // Check if the finger is moving to the right or left
    if (finger.tipVelocity().getX() > 10) {
      // Finger is moving to the right
      fill(0, 255, 0);      
    } else if (finger.tipVelocity().getX() < -10) {
      // Finger is moving to the left
      fill(255, 0, 0);
    }
    ellipse(width/2 + finger.tipPosition().getX(), height/2 - finger.tipPosition().getY(), 50, 50);
  }
}
