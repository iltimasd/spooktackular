// 2B: Shared drawing canvas (Client)

import processing.net.*; 

Client c; 
String input;
int data[]; 

void setup() { 
  size(450, 255);
  frameRate(30); // Slow it down a little
  // Connect to the server’s IP address and port­
  c = new Client(this, "127.0.0.1", 12348); // Replace with your server’s IP and port
} 

void draw() {         
  background(204);

  // Receive data from server

}

void mouseReleased(){
     c.write(1 + "\n");
 
}