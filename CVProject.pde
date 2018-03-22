import processing.video.*;
import gab.opencv.*;

Capture webcam;              // webcam input
OpenCV cv;                   // instance of the OpenCV library
ArrayList<Contour> blobs;    // list of blob contours
int camWidth =  640;   // we'll use a smaller camera resolution, since
int camHeight = 360;   // HD video might bog down our computer

int gridSize =  5; 
boolean debug = false;    // use 'd' key to enable debug mode



void setup() {
   size(1280,720);
  
  //println("- " + displayWidth + " x " + displayHeight + " px");
  //size(displayWidth, displayHeight);


  //if (displayDensity() == 1) {
  //  println("- normal-density display (1x)");
  //} else {
  //  println("- retina display (2x)");
  //}
  //pixelDensity(displayDensity());


  //noCursor();


  cv = new OpenCV(this, width, height);


  String[] inputs = Capture.list();
  if (inputs.length == 0) {
    println("Couldn't detect any webcams connected!");
    exit();
  }
  webcam = new Capture(this, inputs[0]);
  webcam.start();

  textSize(20);
  textAlign(LEFT, BOTTOM);
  println("DISPLAY INFO:");
}


void setting() {
  fullScreen(P2D, 1);
}
void draw() {


  if (webcam.available()) {

    webcam.read();
    image(webcam, 0, 0);
    background(0);
    cv.loadImage(webcam);

    int threshold = int( map(300, 0, height, 0, 255) );
    cv.threshold(threshold);
    cv.invert();   
    cv.dilate();
    //cv.findCannyEdges(20, 75);
    cv.erode();

    //image(cv.getOutput(), 0, 0);
    float color1 = random(200, 255);
    float color2 = random(200, 255);
    float color3 = random(200, 255);

    color col = color(color1, color2, color3);
    float color1_change = random(-5, 5);
    float color2_change = random(-5, 5);
    float color3_change = random(-5, 5);
    color1 += color1_change;
    color2 += color2_change;
    color3 += color3_change;
    blobs = cv.findContours();
    
    noFill();
    //stroke(#C8B9FF);
    stroke(col,100);
    //strokeWeight(.75);
    //int ugh = int( map(300,0,100,195) ); 
    for (Contour blob : blobs) {
      //if (blob.area() < 300) {
      //  continue;
      //}
      

      ArrayList<PVector> pts = blob.getPolygonApproximation().getPoints();
    
      for (int i=0; i<100; i++) {
        PVector p1 = pts.get( int(random(0, pts.size())) );
        PVector p2 = pts.get( int(random(0, pts.size())) );
        line(p1.x, p1.y, p2.x, p2.y);
      }

      //for (PVector pt : blob.getPolygonApproximation().getPoints()) {
      //vertex(pt.x, pt.y);
      //shapeMode(CENTER);
      //triangle(pt.x, pt.y, random(600), pt.y, random(pt.x), random(pt.y));
      //}
    }
  }
}
