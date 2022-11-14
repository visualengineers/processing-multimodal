import gab.opencv.*;
import processing.video.*;
import java.awt.*;

Capture video;
OpenCV opencv;
int leftOrRight = 0;

void setup() {
  size(640, 480);

  String[] cameras = Capture.list();

  // https://processing.org/reference/libraries/video/Capture.html
  if (cameras.length == 0) {
    println("There are no cameras available for capture.");
    exit();
  } else {
    println("Available cameras:");
    for (int i = 0; i < cameras.length; i++) {
      println(cameras[i]);
    }
  }

  video = new Capture(this, 640/2, 480/2, cameras[0]);
  opencv = new OpenCV(this, 640/2, 480/2);
  opencv.loadCascade(OpenCV.CASCADE_FRONTALFACE);

  video.start();
}

void draw() {
  scale(2);
  opencv.loadImage(video);

  image(video, 0, 0 );

  noFill();
  stroke(0, 255, 0);
  strokeWeight(3);
  Rectangle[] faces = opencv.detect();
  if (faces.length > 0) {
    if (faces[0].x < 80 && leftOrRight >= 0) {
      println("LEFT");
      leftOrRight = -1;
    } else if (faces[0].x > 120 && leftOrRight <= 0) {
      println("RIGHT");
      leftOrRight = 1;
    }
  }

  for (int i = 0; i < faces.length; i++) {
    rect(faces[i].x, faces[i].y, faces[i].width, faces[i].height);
  }
}

void captureEvent(Capture c) {
  c.read();
}
