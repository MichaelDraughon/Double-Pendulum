float a1=random(0,TWO_PI);//3*PI/2;
float a2=random(0,TWO_PI);//PI;
int r1=150;
int r2=150;
float g=1;
int m1=40;
int m2=20;
float a1_v=0;
float a2_v=0;
PGraphics canvas;
float prevx2;
float prevy2;
int trailSize=200;
ArrayList<PVector> vals=new ArrayList<PVector>();
void setup() {
  frameRate(60);
  size(700,700);
  background(150);
  canvas=createGraphics(700,700);
  canvas.beginDraw();
  canvas.background(150);
  canvas.endDraw();
}
  

void draw() {
  background(200);
  float num1 = -g * (2 * m1 + m2) * sin(a1);
  float num2 = -m2 * g * sin(a1-2*a2);
  float num3 = -2*sin(a1-a2)*m2;
  float num4 = a2_v*a2_v*r2+a1_v*a1_v*r1*cos(a1-a2);
  float den = r1 * (2*m1+m2-m2*cos(2*a1-2*a2));
  float a1_a = (num1 + num2 + num3*num4) / den;
  num1 = 2 * sin(a1-a2);
  num2 = (a1_v*a1_v*r1*(m1+m2));
  num3 = g * (m1 + m2) * cos(a1);
  num4 = a2_v*a2_v*r2*m2*cos(a1-a2);
  den = r2 * (2*m1+m2-m2*cos(2*a1-2*a2));
  float a2_a = (num1*(num2+num3+num4)) / den;
  
  stroke(0,255,0);
  image(canvas,0,0);
  float x=sin(a1);
  float y=cos(a1);
  x=(x*r1)+width/2;
  y=(y*r1)+height/2;
  strokeWeight(3);
  line(width/2, height/2, x, y);
  
  float x2=sin(a2);
  float y2=cos(a2);
  x2=(x2*r2)+x;
  y2=(y2*r2)+y;
  stroke(255,0,0);
  strokeWeight(3);
  line(x, y, x2, y2);
  
  
  a1_v += a1_a;
  a2_v += a2_a;
  a1 += a1_v;
  a2 += a2_v;
  
  PVector location=new PVector(x2,y2);
  
  //colorMode(HSB);
  //float velcol=map(a2_v,-1,1,0,255);
  //color vcol=color(velcol,255,255);
  //canvas.stroke(velcol);
  
  //canvas.beginDraw();
  //canvas.strokeWeight(1);;
  //canvas.stroke(0,0,0);
  //canvas.line(x2,y2,prevx2,prevy2);
  //canvas.endDraw();
  
  colorMode(RGB);
  canvas.beginDraw();
  canvas.stroke(0);
  if (frameCount > 1) {
    stroke(0);
    strokeWeight(2);
    canvas.line(prevx2, prevy2, x2, y2);
  }
  
  vals.add(0,location);
  if (vals.size()>trailSize) {
    vals.remove(vals.size()-1);
  }
  if (frameCount<=trailSize) {
    for (int i=1; i<vals.size()-1; i++) {
      float[] fval=vals.get(i).array();
      float[] lval=vals.get(i+1).array();
      canvas.line(fval[0],fval[1],lval[0],lval[1]);
    }
  }
  if (frameCount>trailSize) {
    for (int i=1; i<vals.size()-1; i++) {
      float[] fval=vals.get(i).array();
      float[] lval=vals.get(i+1).array();
      canvas.line(fval[0],fval[1],lval[0],lval[1]);
    }
  }
  canvas.endDraw();
  canvas.clear();
  prevx2=x2;
  prevy2=y2;
}