import controlP5.*;
import processing.serial.*;

Serial myPort;
ControlP5 cp5;

int r=7, row=0;
int c=7, clmn=0;
int g=50;
int s=190;
int r1=0, g1=0, b1=0;
color k=color(255, 255, 0);
void setup()
{
  size(740, 660);
  cp5 = new ControlP5(this);
  myPort = new Serial(this, "COM5", 9600);

  cp5.addSlider("sliderR")
    .setPosition(30, 485)
    .setSize(200, 40)
    .setRange(0, 255)
    .setValue(r1)
    ;
  cp5.addSlider("sliderG")
    .setPosition(270, 485)
    .setSize(200, 40)
    .setRange(0, 255)
    .setValue(g1)
    ;
  cp5.addSlider("sliderB")
    .setPosition(510, 485)
    .setSize(200, 40)
    .setRange(0, 255)
    .setValue(b1)
    ;
  // reposition the Label for controller 'slider'
  // cp5.getController("slider").getValueLabel().align(ControlP5.LEFT, ControlP5.BOTTOM_OUTSIDE).setPaddingX(0);
  cp5.getController("sliderR").getCaptionLabel().align(ControlP5.RIGHT, ControlP5.BOTTOM_OUTSIDE).setPaddingX(0);
  cp5.getController("sliderG").getCaptionLabel().align(ControlP5.RIGHT, ControlP5.BOTTOM_OUTSIDE).setPaddingX(0);
  cp5.getController("sliderB").getCaptionLabel().align(ControlP5.RIGHT, ControlP5.BOTTOM_OUTSIDE).setPaddingX(0);

  for (int i=0; i<r; i++)
  {
    for (int j=0; j<c; j++)
    {
      stroke(255-red(k), 255-green(k), 255-blue(k));
      strokeWeight(2);
      fill(k);
      rect((i*g)+s, (j*g)+s-(s/1.5), g, g);
    }
  }
}

void draw()
{
  
  stroke(255-red(k), 255-green(k), 255-blue(k));
  strokeWeight(2);
  fill(k);
  rect((row*g)+s, (clmn*g)+ s-(s/1.5), g, g);
}
void mousePressed()
{
  for (int i=0; i<=r; i++)
  {
    for (int j=0; j<=c; j++)
    {
      if (mouseX>=(i*g)+s &&mouseY>=(j*g)+s-(s/1.5) &&mouseX<(i*g)+s+g && mouseY<(j*g)+s-(s/1.5)+g)
      {
        row=i;
        clmn=j;
        int d=i+(j*c);
        int l=(j%2)*(d+2*(3-i))+(1-(j%2))*d;
        println(l, r1, g1, b1);
        myPort.write(l);
        myPort.write(r1);
        myPort.write(g1);
        myPort.write(b1);
      }
    }
  }
}
void sliderR( int rr) {
  r1=rr;
  k=color(r1, g1, b1);
}
void sliderG(int gg) {
  g1=gg;
  k=color(r1, g1, b1);
}
void sliderB(int  bb) {
  b1=bb;
  k=color(r1, g1, b1);
}
