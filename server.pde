// 2A: Shared drawing canvas (Server)

import processing.net.*;

Server s;
Server s2;
Server s3;  
Client c, c2, c3;
String input;
String input2;
String input3;
int data[];
int data2[];
int data3[];
float angle;
float sinval;
PImage ghost, ghost2, ghost3;


void setup() { 
  size(600, 400);
  background(204);
  frameRate(30); // Slow it down a little
  s = new Server(this, 12345);  // Start a simple server on a port
  s2 = new Server(this, 12356);  // Start a simple server on a port
  s3 = new Server(this, 12367);  // Start a simple server on a port
  ghost  = loadImage("halloweenGhost.png");
  ghost2 = loadImage("halloweenGhost2.png");
  ghost3 = loadImage("halloweenGhost3.png");
} 
void draw() { 
  noStroke();
  fill(29,78,94);
  rect(0,0,width,height);
  if (mousePressed == true) {
    // Draw our line
    stroke(255);
    line(pmouseX, pmouseY, mouseX, mouseY); 
    // Send mouse coords to other person
    s.write(pmouseX + " " + pmouseY + " " + 50 + " " + 50 + "\n");
  }
  sinval = sin(angle);   
  float fading = sinval*100;
  map(fading,-1,1,0,400);
  println(fading);   
  angle += 0.1;
  
  // Receive data from client
  c = s.available();
  if (c != null) {
    input = c.readString(); 
    input = input.substring(0, input.indexOf("\n"));  // Only up to the newline
    data = int(split(input, ' '));  // Split values into an array
    // Draw using received coords
    //stroke(0);
    //fill(0,201,0);
    tint(255, fading);
    image(ghost,data[0], data[1]);
    
  }
  
  c2 = s2.available();
  if (c2 != null) {
    input2 = c2.readString(); 
    input2 = input2.substring(0, input2.indexOf("\n"));  // Only up to the newline
    data2 = int(split(input2, ' '));  // Split values into an array
    // Draw using received coords
    //stroke(0);
    //fill(255);
     tint(255, fading);
    image(ghost2,data2[0], data2[1]);
    
  }
  
   c3 = s3.available();
  if (c3 != null) {
    input3 = c3.readString(); 
    input3 = input3.substring(0, input3.indexOf("\n"));  // Only up to the newline
    data3 = int(split(input3, ' '));  // Split values into an array
    // Draw using received coords
    //stroke(0);
    //fill(255);
     tint(255, fading);
    image(ghost3,data3[0], data3[1]);
    
  }
}