import controlP5.*;

Expression ex;
ControlP5 ip;
Textfield expression;

void setup(){
  size(1000, 800, P2D);
  frameRate(60);
  background(20);

  ex = new Expression();

  ip = new ControlP5(this);
  ip.addButton("evaluate")
     .setPosition(width / 2,10)
     .setSize(50,20)
  ;
  expression = ip.addTextfield("expression")
     .setPosition(width / 2 - 120, 10)
     .setSize(100, 20)
  ;
  expression.setText("a+(b*c-6^c)");
  textFont(createFont("arial",20));



}

void draw(){
  background(20);
}

void evaluate(){
  ex.evaluate(expression.getText());
  ex.showTree();
}
