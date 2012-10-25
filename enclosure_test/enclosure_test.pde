import cc.arduino.*;

import processing.serial.*;

Arduino arduino;

float analogFill;

void setup() {
  size(400,600);
  
  print(Arduino.list()); //Finding arduino port
  arduino = new Arduino(this, Arduino.list()[0], 57600); //finds Arduino
  arduino.pinMode(12, Arduino.INPUT); //BUTTON
  
  arduino.pinMode(4, Arduino.OUTPUT); //LED, GrEEN
  arduino.pinMode(8, Arduino.OUTPUT); //LED, RED
  
  noStroke();
  rectMode(CENTER);
}

void draw(){
  background(255, 0, 0);
  
  //Button input
  if(arduino.digitalRead(12) == Arduino.HIGH) {
    fill(255);
  }
  else{
    fill(0);
  }
  rect(200,150,50,50);
  
  //Pot input
  analogFill = map(arduino.analogRead(0), 0, 1023, 0, 255); //maps value
  fill(analogFill); 
  
  rect(200,210,50,50);
  
  //LED output
  if(mousePressed){
    arduino.digitalWrite(4, Arduino.HIGH);
    arduino.digitalWrite(8, Arduino.HIGH);
    fill(255);
  }
  else{
    arduino.digitalWrite(4, Arduino.LOW);
    arduino.digitalWrite(8, Arduino.LOW);
    fill(0);
  }
  rect(200,270,50,50);
  
}
