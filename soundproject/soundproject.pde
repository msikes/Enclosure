import processing.serial.*;

import cc.arduino.*;

import ddf.minim.*;
import ddf.minim.signals.*;
import ddf.minim.analysis.*;
import ddf.minim.effects.*;

Arduino arduino;

Minim minim;
AudioInput in;
BandPass bpf;
BeatDetect beat;
BeatListener bl;

InputOutputBind signal;

AudioOutput out;

float analogFill;
float pitch;
float pitch2;

AudioSample beep1;
AudioSample beep2;
AudioSample beep3;
AudioSample beep4;
AudioSample beep5;

AudioSample elevator1;
AudioSample elevator2;
AudioSample elevator3;
AudioSample elevator4;
AudioSample elevator5;

PImage topoverlay;
PImage button;
PImage greenON;
PImage redON;

int buttonVal=1;

void setup() {

  size(512, 550, P2D);

  topoverlay = loadImage("overlay.png");
  button = loadImage("buttonPRESS.png");
  greenON = loadImage("greenON.png");
  redON = loadImage("redON.png");
  print(Arduino.list());
  arduino = new Arduino(this, Arduino.list()[0], 57600);
  arduino.pinMode(9, Arduino.INPUT);//button
  arduino.pinMode(12, Arduino.OUTPUT);//green led

  minim = new Minim(this);
 // out = minim.getLineOut(Minim.STEREO, 512);
  in = minim.getLineIn(Minim.MONO, 512);
  //bpf filter helps beatDetection algo when bass beat detection is only //wanted
  //bpf = new BandPass(340, 100, in.sampleRate());
 // in.addEffect(bpf);
  beat = new BeatDetect();
  //beat.setSensitivity(3);

  signal = new InputOutputBind(512);
  //add listener to gather incoming data
  in.addListener(signal);
  // adds the signal to the output
  //out.addSignal(signal);
  beep1 = minim.loadSample("elevator1.mp3");
  beep2 = minim.loadSample("elevator2.mp3");
  beep3 = minim.loadSample("elevator3.mp3");
  beep4 = minim.loadSample("elevator4.mp3");
  beep5 = minim.loadSample("elevator5.mp3");
  elevator1 = minim.loadSample("elevator1a.mp3");
  elevator2 = minim.loadSample("elevator2a.mp3");
  elevator3 = minim.loadSample("elevator3a.mp3");
  elevator4 = minim.loadSample("elevator4a.mp3");
  elevator5 = minim.loadSample("elevator5a.mp3");
}

void draw() {
  background(0);

  ///////////////////////////////////////////////////////
  rect(10, 10, width, 200);
  stroke(255);
  // draw the waveforms in
  for (int i = 0; i < in.bufferSize() - 1; i++)
  {
    line(i, 100 + in.left.get(i)*50, i+1, 100 + in.left.get(i+1)*50);
    //line(i, 150 + in.right.get(i)*50, i+1, 150 + in.right.get(i+1)*50);
  }
  // out
  noStroke();
  fill(0);
  rect(0, 200, width, 200);
  stroke(255);
  for (int i = 0; i < in.bufferSize() - 1; i++)
  {
    line(i, 300 + in.left.get(i)*50, i+1, 300 + in.left.get(i+1)*50);
    //line(i, 350 + out.right.get(i)*50, i+1, 350 + out.right.get(i+1)*50);
  }
  fill(0);
  noStroke();
  //////////////////////////////////////////////////


  beat.detect(in.mix);
  //pot stuff
  analogFill = map(arduino.analogRead(0), 0, 1023, 0, 255);
  fill(255);
  text("pitch:", 100, 450);
  float analogFill2;
  analogFill2=map(analogFill, 0, 255, 0, 10);
  int analogDisplay = round(analogFill2);
  text(analogDisplay, 133, 450);
  fill(analogFill); 
  rect(100, 460, 50, 50);
  pitch = map(analogFill, 0, 255, 0, 1);
  pitch2 = map(pitch, 0, 1, 1, 5);
  int pitchDisplay = round(pitch2);
  //println(pitchDisplay);
  fill(0);
  arduino.digitalWrite(7, Arduino.LOW);
  ///////////////////////////////////////////////////KICK
  image(topoverlay, 0, 0);
  fill(130, 130, 130);
  text(pitchDisplay, 384, 440);
  if ( beat.isOnset() && buttonVal>0 && pitch<0.2)
  {
    println("beat!");
    arduino.digitalWrite(12, Arduino.HIGH);
    beep1.trigger();
    image(greenON, 0, 0);
  }

  if ( beat.isOnset() && buttonVal>0 && pitch>0.2 && pitch<0.4)
  {
    println("beat!");
    arduino.digitalWrite(12, Arduino.HIGH);
    beep2.trigger();
    image(greenON, 0, 0);
  }

  if ( beat.isOnset() && buttonVal>0 && pitch>0.4 && pitch<0.6)
  {
    println("beat!");
    arduino.digitalWrite(12, Arduino.HIGH);
    beep3.trigger();
    image(greenON, 0, 0);
  }

  if ( beat.isOnset() && buttonVal>0 && pitch>0.6 && pitch<0.8)
  {
    println("beat!");
    arduino.digitalWrite(12, Arduino.HIGH);
    beep4.trigger();
    image(greenON, 0, 0);
  }

  if ( beat.isOnset() && buttonVal>0 && pitch>0.8)
  {
    println("beat!");
    arduino.digitalWrite(12, Arduino.HIGH);
    beep5.trigger();
    image(greenON, 0, 0);
  }
  ///////////////////////////////////////////////TONE
  if ( beat.isOnset() && buttonVal<0 && pitch<0.2)
  {
    println("beat!");
    arduino.digitalWrite(12, Arduino.HIGH);
    elevator1.trigger();
    image(greenON, 0, 0);
  }

  if ( beat.isOnset() && buttonVal<0 && pitch>0.2 && pitch<0.4)
  {
    println("beat!");
    arduino.digitalWrite(12, Arduino.HIGH);
    elevator2.trigger();
    image(greenON, 0, 0);
  }

  if ( beat.isOnset() && buttonVal<0 && pitch>0.4 && pitch<0.6)
  {
    println("beat!");
    arduino.digitalWrite(12, Arduino.HIGH);
    elevator3.trigger();
    image(greenON, 0, 0);
  }

  if ( beat.isOnset() && buttonVal<0 && pitch>0.6 && pitch<0.8)
  {
    println("beat!");
    arduino.digitalWrite(12, Arduino.HIGH);
    elevator4.trigger();
    image(greenON, 0, 0);
  }

  if ( beat.isOnset() && buttonVal<0 && pitch>0.8)
  {
    println("beat!");
    arduino.digitalWrite(12, Arduino.HIGH);
    elevator5.trigger();
    image(greenON, 0, 0);
  }

  /////////////////////////////////////////////////////////


  if (arduino.digitalRead(9) == Arduino.HIGH) {
    buttonVal=1;
    image(button, 0, 0);
    arduino.digitalWrite(7, Arduino.HIGH);
    image(redON, 0, 0);
  }

  else {
    arduino.digitalWrite(12, Arduino.LOW);
    buttonVal=-1;
    fill(255);
  }
  fill(0);
}

void stop()
{
  // always close Minim audio classes when you are finished with them
  in.close();
  // always stop Minim before exiting
  minim.stop();
  // this closes the sketch
  super.stop();
}

class BeatListener implements AudioListener
{
  private BeatDetect beat;
  private AudioPlayer source;

  BeatListener(BeatDetect beat, AudioPlayer source)
  {
    this.source = source;
    this.source.addListener(this);
    this.beat = beat;
  }

  void samples(float[] samps)
  {
    beat.detect(source.mix);
  }

  void samples(float[] sampsL, float[] sampsR)
  {
    beat.detect(source.mix);
  }
}

class InputOutputBind implements AudioSignal, AudioListener
{
  private float[] leftChannel ;
  private float[] rightChannel;
  InputOutputBind(int sample)
  {
    leftChannel = new float[sample];
    rightChannel= new float[sample];
  }
  // This part is implementing AudioSignal interface, see Minim reference
  void generate(float[] samp)
  {
    arraycopy(leftChannel, samp);
  }
  void generate(float[] left, float[] right)
  {
    arraycopy(leftChannel, left);
    arraycopy(rightChannel, right);
  }
  // This part is implementing AudioListener interface, see Minim reference
  synchronized void samples(float[] samp)
  {
    arraycopy(samp, leftChannel);
  }
  synchronized void samples(float[] sampL, float[] sampR)
  {
    arraycopy(sampL, leftChannel);
    arraycopy(sampR, rightChannel);
  }
}

