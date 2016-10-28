// 2A: Shared drawing canvas (Server)

import processing.net.*;

import processing.sound.*;
SoundFile file;

Server s, s2, s3, s4;
Client c, c2, c3, c4;
String input, input2, input3, input4;
int data[], data2[], data3[];
float angle;
float sinval;
PImage ghost, ghost2, ghost3, bg, batty;
ArrayList<Bat> bats;

////////SETUP//////////////////////////
void setup() { 
  size(1100, 600);
  background(204);
  frameRate(30); // Slow it down a little
  s = new Server(this, 12345);  // Start a simple server on a port
  s2 = new Server(this, 12356);  // Start a simple server on a port
  s3 = new Server(this, 12367);  // Start a simple server on a port
  s4 = new Server(this, 12348);  // Start a simple server on a port

  bats = new ArrayList<Bat>();
  bats.add(new Bat(0, 0, 3));

  ghost  = loadImage("ghost01.png");
  ghost2 = loadImage("ghost02.png");
  ghost3 = loadImage("ghost03.png");
  bg     = loadImage("graveyard.png");
  batty=loadImage("bat.png");
} 
//////////SETUP//////////////



void draw() { 
  noStroke();
  image(bg,0,0);
  if (mousePressed == true) {
    // Draw our line
    stroke(255);
    line(pmouseX, pmouseY, mouseX, mouseY);
    s.write(pmouseX + " " + pmouseY + " " + 50 + " " + 50 + "\n");
  }
  if ((mousePressed==true)&&( mouseX ==data[0])){
   rect(data[0]-100,data[1]-91,200,267); 
  }
  
  sinval = sin(angle);   
  float fading = sinval;
  float faded =map(fading, -1, 1, 200, 400);
  println(faded);   
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
    file = new SoundFile(this, "ghostsound.mp3");
    file.play();
    tint(255, 100);
    image(ghost, data[0], data[1], 200, 267);
  }

  c2 = s2.available();
  if (c2 != null) {
    input2 = c2.readString(); 
    input2 = input2.substring(0, input2.indexOf("\n"));  // Only up to the newline
    data2 = int(split(input2, ' '));  // Split values into an array
    // Draw using received coords
    //stroke(0);
    //fill(255);
    file = new SoundFile(this, "ghostsound.mp3");
    file.play();
    tint(255, 100);
    image(ghost2, data2[0], data2[1], 200, 267);
  }

c3 = s3.available();
  if (c3 != null) {
    input3 = c3.readString(); 
    input3 = input3.substring(0, input3.indexOf("\n"));  // Only up to the newline
    data3 = int(split(input3, ' '));  // Split values into an array
    // Draw using received coords
    //stroke(0);
    //fill(255);
    file = new SoundFile(this, "ghostsound.mp3");
    file.play();
    tint(255, 100);
    image(ghost3, data3[0], data3[1], 200, 267);
  }
  
  c4 = s4.available();
  if (c4 != null) {
    input4 = c4.readString(); 
    input4 = input4.substring(0, input4.indexOf("\n"));  // Only up to the newline
    print(input4);
    if (input4.equals("1")) {
      float r=random(0, 10);
      if (r<5) {
        bats.add(new Bat(0, random(0, height), random(7, 15)));
      } else {
        bats.add(new Bat(width, random(0, height), random(-7, -15)));
      }
      input4="0";
    }
    print(input4);
  }

  for (int i = bats.size()-1; i >= 0; i--) { 
    Bat bat =  bats.get(i);
    bat.fly();
    bat.display();
  }
}

class Bat { 
  float xpos;
  float ypos;
  float xspeed;

  // The Constructor is defined with arguments.
  Bat( float tempXpos, float tempYpos, float tempXspeed) { 
    xpos = tempXpos;
    ypos = tempYpos;
    xspeed = tempXspeed;
  }

  void display() {
    stroke(0);
    fill(0);
    image(batty,xpos, ypos, 60, 30);
  }

  void fly() {
    xpos = xpos + xspeed;
  }
}
