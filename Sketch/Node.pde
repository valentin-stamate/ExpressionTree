public class Node{
  char expression;

  boolean isShowing = true;

  Node left;
  Node right;

  int radius = 30;
  int x = 400, y = 0;
  int offset = 0;

  Node(char c){
    this.expression = c;
    registerMethod("draw", this);
    registerMethod("mouseEvent", this);
  }

  void draw(){
    if(isShowing){
      noStroke();
      fill(255);
      circle(x, y + offset, radius);
      fill(20);
      text(expression, x - 6, y + 5);
    }
  }

  void offset(int o){
    y += o;
  }

  boolean isSelected;
  void mouseEvent(MouseEvent event) {
    if ((!this.isSelected && isOver(mouseX, mouseY)) || this.isSelected ) {
      switch(event.getAction()) {
      case MouseEvent.PRESS:
        this.isSelected = true;
        break;
      case MouseEvent.DRAG:
        x = x + mouseX - pmouseX;
        //y = y + mouseY - pmouseY;
        break;
      case MouseEvent.RELEASE:
        isSelected = false;
        break;
      }
    }
  }

  boolean isOver(int mx, int my) {
    return (mx - x) * (mx - x) + (my - y) * (my - y) < (radius - 5) * (radius - 5);
  }

}
