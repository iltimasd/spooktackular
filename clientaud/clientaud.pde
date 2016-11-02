// Audience Client, adding to the scene

import processing.net.*; 

Client c; 
String input;
int data[]; 

void setup() { 
  size(450, 255);
  frameRate(30); // Slow it down a little
  // Connect to the server’s IP address and port­
  c = new Client(this, "127.0.0.1", 12348); // Replace with your server’s IP and port

  textSize(32);
  textAlign(CENTER);
} 

void draw() {         
  background(100);
  fill(255,79,10);
  text("Click for BATS on the stage",width/2,height/2);

}

void mouseReleased(){
     c.write(1 + "\n");
 
}
