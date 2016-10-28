// 2B: Shared drawing canvas (Client)

import processing.net.*; 

Client c3; 
String input;
int data[]; 

void setup() { 
  size(450, 255);
  frameRate(30); // Slow it down a little
  // Connect to the server’s IP address and port­
  c3 = new Client(this, "127.0.0.1", 12367); // Replace with your server’s IP and port
} 

void draw() {
  background(204);
  if (mousePressed == true) {

    stroke(255);
    line(pmouseX, pmouseY, mouseX, mouseY); 
    rect(pmouseX-50, pmouseY-50, 100,100);
    // Send mouse coords to other person
    c3.write(pmouseX + " " + pmouseY + " " + mouseX + " " + mouseY + "\n");
  }

  // Receive data from server
  if (c3.available() > 0) { 
    input = c3.readString(); 
    input = input.substring(0,input.indexOf("\n"));  // Only up to the newline
    data = int(split(input, ' '));  // Split values into an array
    // Draw line using received coords
    stroke(0);
    rect(data[0], data[1], data[2], data[3]); 
  } 
}