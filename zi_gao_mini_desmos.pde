import controlP5.*;

float x = -250;
float x1, x2, x1z, x2z;
float area = 0;
float c = 1;
float xPos, yPos, oy, ox;
boolean set = false;
boolean showArea = false;
boolean showZero = false;
ArrayList <PVector> point = new ArrayList<PVector>();
float lim = 0; 
int equationState = 0;
float kVal, aVal, bVal, qVal;
float oldkVal, oldaVal, oldbVal, oldqVal;
ArrayList <Float> zeros = new ArrayList<Float>();
ControlP5 cp5;

Button fSin = new Button(770, 200, 120, 70, "Sin(x)");
Button fCos = new Button(930, 200, 120, 70, "Cos(x)");
Button fSquare = new Button(770, 300, 120, 70, "(x)^2");
Button fCube = new Button(930, 300, 120, 70, "(x)^3");
Button fExponential = new Button(850, 400, 120, 70, "b^(x)");
Button calcArea = new Button (280, 800, 220, 40, "Calculate Area");
Button calcZeros = new Button (720, 800, 220, 40, "Find Zeros");

void setup() {
  size(1000, 1000);
  PFont font = createFont("arial", 15);
  cp5 = new ControlP5(this);
  cp5.addTextfield("A Value")
    .setPosition(760, 550)
    .setSize(30, 30)
    .setFont(font)
    .setFocus(true)
    .setColor(color(255, 255, 255))
    .setVisible(false)
    .setText("1")
    ;
  cp5.addTextfield("B Value")
    .setPosition(890, 550)
    .setSize(30, 30)
    .setFont(font)
    .setFocus(false)
    .setColor(color(255, 255, 255))
    .setVisible(false)
    .setText("0")
    ;
  cp5.addTextfield("K Value")
    .setPosition(760, 650)
    .setSize(30, 30)
    .setFont(font)
    .setFocus(false)
    .setColor(color(255, 255, 255))
    .setVisible(false)
    .setText("1")
    ;
  cp5.addTextfield("Q Value")
    .setPosition(890, 650)
    .setSize(30, 30)
    .setFont(font)
    .setFocus(false)
    .setColor(color(255, 255, 255))
    .setVisible(false)
    .setText("0")
    ;
  cp5.addTextfield("X1")
    .setPosition(200, 840)
    .setSize(30, 30)
    .setFont(font)
    .setFocus(false)
    .setColor(color(255, 255, 255))
    .setText("0")
    ;
  cp5.addTextfield("X2")
    .setPosition(320, 840)
    .setSize(30, 30)
    .setFont(font)
    .setFocus(false)
    .setColor(color(255, 255, 255))
    .setText("0")
    ;
  cp5.addTextfield("x1")
    .setPosition(650, 840)
    .setSize(30, 30)
    .setFont(font)
    .setFocus(false)
    .setColor(color(255, 255, 255))
    .setText("0")
    ;
  cp5.addTextfield("x2")
    .setPosition(770, 840)
    .setSize(30, 30)
    .setFont(font)
    .setFocus(false)
    .setColor(color(255, 255, 255))
    .setText("0")
    ;
}

void draw() {
  background(255);
  drawGraph();
  drawMenu();
  customizeGraph();
}

void updateGraph() {
  point.clear();
  x = -250;
  switch (equationState) {
  case 1:
    while (point.size() < 5000) {
      float _x = map(x, -250, 250, -1250, 1250); 
      point.add(new PVector(_x + 350, ((-aVal*(sin((kVal*x) + qVal))) - bVal)*5 + 350));
      x+=0.1;
    }
    break;
  case 2:
    while (point.size() < 5000) {
      float _x = map(x, -250, 250, -1250, 1250); 
      point.add(new PVector(_x + 350, ((-aVal*(cos((kVal*x) + qVal))) - bVal)*5 + 350));
      x+=0.1;
    }
    break;
  case 3:
    while (point.size() < 5000) {
      float _x = map(x, -250, 250, -1250, 1250); 
      point.add(new PVector(_x + 350, ((-aVal*pow(x, 2)-kVal*x-bVal)*5 + 350)));
      x+=0.1;
    }
    break;
  case 4:
    while (point.size() < 5000) {
      float _x = map(x, -250, 250, -1250, 1250); 
      point.add(new PVector(_x + 350, (-aVal*pow(x, 3)-qVal*pow(x, 2)-kVal*x-bVal)*5 + 350));
      x+=0.1;
    }
    break;
  case 5:
    while (point.size() < 5000) {
      float _x = map(x, -250, 250, -1250, 1250); 
      point.add(new PVector(_x + 350, (-aVal*pow(bVal, x)-qVal)*5 + 350));
      x+=0.1;
    }
    break;
  }
}

void drawMenu() {
  strokeWeight(1.5);
  stroke(50);
  fill(120, 89, 120);
  textAlign(CENTER);
  rectMode(CORNER);
  rect(0, 750, width, 250);
  rect(700, 0, 300, 750);
  calcArea.update();
  calcZeros.update();
  fSin.update();
  fCos.update();
  fSquare.update();
  fCube.update();
  fExponential.update();
  textSize(70);
  text("Graph", 850, 60);
  text("Creator", 850, 130);

  if (fSin.clicked) {
    fCos.clicked = false; 
    fSquare.clicked = false;
    fCube.clicked = false;
    fExponential.clicked = false;
    fSin.clicked = false;
    equationState = 1;
    cp5.get(Textfield.class, "Q Value").setValue("0");
    cp5.get(Textfield.class, "B Value").setValue("0");
    cp5.get(Textfield.class, "K Value").setValue("1");
    cp5.get(Textfield.class, "A Value").setValue("1");
    updateGraph();
  } 
  if (fCos.clicked) {
    fCos.clicked = false; 
    fSquare.clicked = false;
    fExponential.clicked = false;
    fSin.clicked = false;
    fCube.clicked = false;
    equationState = 2;
    cp5.get(Textfield.class, "Q Value").setValue("0");
    cp5.get(Textfield.class, "B Value").setValue("0");
    cp5.get(Textfield.class, "K Value").setValue("1");
    cp5.get(Textfield.class, "A Value").setValue("1");
    updateGraph();
  }
  if (fSquare.clicked) {
    fCos.clicked = false; 
    fSquare.clicked = false;
    fExponential.clicked = false;
    fSin.clicked = false;
    fCube.clicked = false;
    equationState = 3;
    cp5.get(Textfield.class, "Q Value").setValue("0");
    cp5.get(Textfield.class, "B Value").setValue("0");
    cp5.get(Textfield.class, "K Value").setValue("0");
    cp5.get(Textfield.class, "A Value").setValue("1");
    updateGraph();
  } 
  if (fExponential.clicked) {
    fCos.clicked = false; 
    fSquare.clicked = false;
    fExponential.clicked = false;
    fSin.clicked = false;
    fCube.clicked = false;
    equationState = 5;
    cp5.get(Textfield.class, "Q Value").setValue("0");
    cp5.get(Textfield.class, "B Value").setValue("2");
    cp5.get(Textfield.class, "K Value").setValue("0");
    cp5.get(Textfield.class, "A Value").setValue("1");
    updateGraph();
  }
  if (fCube.clicked) {
    fCos.clicked = false; 
    fSquare.clicked = false;
    fExponential.clicked = false;
    fSin.clicked = false;
    fCube.clicked = false;
    equationState = 4;
    cp5.get(Textfield.class, "Q Value").setValue("0");
    cp5.get(Textfield.class, "B Value").setValue("0");
    cp5.get(Textfield.class, "K Value").setValue("0");
    cp5.get(Textfield.class, "A Value").setValue("1");
    updateGraph();
  }
  if (calcArea.clicked) {
    calcArea.clicked = false;
    calculateArea();
    showArea = true;
  }
  if (calcZeros.clicked) {
    zeros.clear();
    calcZeros.clicked = false;
    lim = float(cp5.get(Textfield.class, "x2").getText());
    x1z = float(cp5.get(Textfield.class, "x1").getText());
    x2z = float(cp5.get(Textfield.class, "x1").getText());
    findZeros();
    showZero = true;
  }
  textSize(15);
  if (showArea) {
    text("The Area From " + x1 + " to " + x2, 280, 920);
    text("Is Approximately: " + area, 280, 960);
  }
  if (showZero) {
    text("The Zeroes From " + x1 + " to " + x2 + " are at:", 725, 920);
    for (int i = 0; i < zeros.size(); i++){
     text(zeros.get(i), 725, i*20+940);
    }
  }
}

void drawGraph() {
  pushMatrix();  
  translate(xPos, yPos);
  scale(c);
  stroke(100);
  strokeWeight(0.2);
  for (int i = -500; i < 500; i++) {
    line(-25000, i*50, 25000, i*50);
    line(i*50, -25000, i*50, 25000);
  }
  stroke(100);
  strokeWeight(0.2);
  for (int i = -5000; i < 5000; i++) {
    line(-25000, i*5, 25000, i*5);
    line(i*5, -25000, i*5, 25000);
  }
  stroke(0);
  strokeWeight(1);
  line(-25000, 350, 25000, 350);
  line(350, -25000, 350, 25000);

  if (point.size() > 0) {
    for (int i = 1; i < point.size(); i++) {
      PVector myPoint = point.get(i);
      PVector myPoint2 = point.get(i-1);
      stroke(120, 89, 120);
      strokeWeight(1);
      line(myPoint.x, myPoint.y, myPoint2.x, myPoint2.y);
    }
  }
  popMatrix();

  if (oldaVal != aVal || oldbVal != bVal || oldkVal != kVal || oldqVal != qVal) {
    updateGraph();
    oldaVal = aVal;
    oldbVal = bVal;
    oldkVal = kVal;
    oldqVal = qVal;
  }
}

void customizeGraph() {
  switch (equationState) {
  case 0: 
    textSize(20);
    text("Select A Family to Continue", 850, 570);
    break;

  case 1:
    cp5.get(Textfield.class, "A Value").setVisible(true);
    cp5.get(Textfield.class, "B Value").setVisible(true);
    cp5.get(Textfield.class, "K Value").setVisible(true);
    cp5.get(Textfield.class, "Q Value").setVisible(true);
    aVal = float(cp5.get(Textfield.class, "A Value").getText());
    bVal = float(cp5.get(Textfield.class, "B Value").getText());
    kVal = float(cp5.get(Textfield.class, "K Value").getText());
    qVal = float(cp5.get(Textfield.class, "Q Value").getText());
    textSize(15);
    text("f(x) = " + aVal + "sin(" + kVal + "x+" + qVal + ") + " + bVal, 850, 500);
    break;

  case 2:
    cp5.get(Textfield.class, "A Value").setVisible(true);
    cp5.get(Textfield.class, "B Value").setVisible(true);
    cp5.get(Textfield.class, "K Value").setVisible(true);
    cp5.get(Textfield.class, "Q Value").setVisible(true);
    aVal = float(cp5.get(Textfield.class, "A Value").getText());
    bVal = float(cp5.get(Textfield.class, "B Value").getText());
    kVal = float(cp5.get(Textfield.class, "K Value").getText());
    qVal = float(cp5.get(Textfield.class, "Q Value").getText());
    textSize(15);
    text("f(x) = " + aVal + "cos(" + kVal + "x+" + qVal + ") + " + bVal, 850, 500);
    break;


  case 3:
    cp5.get(Textfield.class, "A Value").setVisible(true);
    cp5.get(Textfield.class, "B Value").setVisible(true);
    cp5.get(Textfield.class, "K Value").setVisible(true);
    cp5.get(Textfield.class, "Q Value").setVisible(false);
    aVal = float(cp5.get(Textfield.class, "A Value").getText());
    bVal = float(cp5.get(Textfield.class, "B Value").getText());
    kVal = float(cp5.get(Textfield.class, "K Value").getText());
    qVal = float(cp5.get(Textfield.class, "Q Value").getText());
    textSize(15);
    text("f(x) = " + aVal + "x^2 + " + kVal + "x + " + bVal, 850, 500);
    break;


  case 4:
    cp5.get(Textfield.class, "A Value").setVisible(true);
    cp5.get(Textfield.class, "B Value").setVisible(true);
    cp5.get(Textfield.class, "K Value").setVisible(true);
    cp5.get(Textfield.class, "Q Value").setVisible(true);
    aVal = float(cp5.get(Textfield.class, "A Value").getText());
    bVal = float(cp5.get(Textfield.class, "B Value").getText());
    kVal = float(cp5.get(Textfield.class, "K Value").getText());
    qVal = float(cp5.get(Textfield.class, "Q Value").getText());
    textSize(15);
    text("f(x) = " + aVal + "x^3 + " + qVal + "x^2 + " + kVal + "x + " + bVal, 850, 500);
    break;

  case 5:
    cp5.get(Textfield.class, "A Value").setVisible(true);
    cp5.get(Textfield.class, "B Value").setVisible(true);
    cp5.get(Textfield.class, "K Value").setVisible(false);
    cp5.get(Textfield.class, "Q Value").setVisible(true);
    aVal = float(cp5.get(Textfield.class, "A Value").getText());
    bVal = float(cp5.get(Textfield.class, "B Value").getText());
    kVal = float(cp5.get(Textfield.class, "K Value").getText());
    qVal = float(cp5.get(Textfield.class, "Q Value").getText());
    textSize(15);
    text("f(x) = " + aVal + "(" + bVal + ")^x + " + qVal, 850, 500);
    break;
  }
}

void calculateArea() {
  area = 0;
  x1 = float(cp5.get(Textfield.class, "X1").getText());
  x2 = float(cp5.get(Textfield.class, "X2").getText());

  switch (equationState) {
  case 1:
    for (float i = x1; i < x2; i+=0.00001) {
      area = area + abs(aVal*sin(kVal*i)*0.00001);
    }
    break;
  case 2:
    for (float i = x1; i < x2; i+=0.00001) {
      area = area + abs(aVal*cos(kVal*i)*0.00001);
    }
    break;
  case 3:
    for (float i = x1; i < x2; i+=0.00001) {
      area = area + abs((aVal*pow(i, 2)+kVal*x+bVal)*0.00001);
    }
    break;
  case 4:
    for (float i = x1; i < x2; i+=0.00001) {
      area = area + abs((aVal*pow(i, 3)+qVal*pow(x, 2)+kVal*x+bVal)*0.00001);
    }
    break;
  case 5:
    for (float i = x1; i < x2; i+=0.00001) {
      area = area + abs((aVal*pow(bVal, i)+qVal)*0.00001);
    }
    break;
  }
}


void findZeros() {
  println(x1z, x2z, lim);
  switch (equationState) {
  case 1: 
    while (x2z < lim) {
      if (((aVal*sin((kVal*x1z) + qVal)) + bVal) <= 0) {
        println(((aVal*sin((kVal*x1z) + qVal)) + bVal));
        while (((aVal*sin((kVal*x2z) + qVal)) + bVal) <= 0) {
          if (x2z < lim) {
            x2z+=0.1;
          } else {
            break;
          }
        }
        if (x2z < lim) {
          println(x2z);
          calculate(x1z, x2z);
        }
      } else {
        while (((aVal*sin((kVal*x2z) + qVal)) + bVal) >= 0) {
          if (x2z < lim) {
            x2z+=0.1;
          } else {
            break;
          }
        }
        if (x2z < lim) {
          calculate(x2z, x1z);
        }
      }
      x1z = x2z;
    }
    break;
  case 2: 
    while (x2z < lim) {
      if (((aVal*cos((kVal*x1z) + qVal)) + bVal) <= 0) {
        while (((aVal*cos((kVal*x2z) + qVal)) + bVal) <= 0) {
          if (x2z < lim) {
            x2z+=0.1;
          } else {
            break;
          }
        }
        if (x2z < lim) {
          calculate(x1z, x2z);
        }
      } else {
        while (((aVal*cos((kVal*x2z) + qVal)) + bVal) >= 0) {
          if (x2z < lim) {
            x2z+=0.1;
          } else {
            break;
          }
        }
        if (x2z < lim) {
          calculate(x2z, x1z);
        }
      }
      x1z = x2z;
    }
    break;
  case 3: 
    while (x2z < lim) {
      if ((aVal*pow(x2z, 2)+kVal*x2z+bVal) <= 0) {
        while ((aVal*pow(x2z, 2)+kVal*x2z+bVal) <= 0) {
          if (x2z < lim) {
            x2z+=0.1;
          } else {
            break;
          }
        }
        if (x2z < lim) {
          calculate(x1z, x2z);
        }
      } else {
        while ((aVal*pow(x2z, 2)+kVal*x2z+bVal) >= 0) {
          if (x2z < lim) {
            x2z+=0.1;
          } else {
            break;
          }
        }
        println(x2z);
        if (x2z < lim) {
          calculate(x2z, x1z);
        }
      } 
      x1z = x2z;
    }
    break;
  case 4: 
    while (x2z < lim) {
      if ((aVal*pow(x2z, 3)+qVal*pow(x2z, 2)+kVal*x2z+bVal) <= 0) {
        while ((aVal*pow(x2z, 3)+qVal*pow(x2z, 2)+kVal*x2z+bVal) <= 0) {
          if (x2z < lim) {
            x2z+=0.1;
          } else {
            break;
          }
        }
        if (x2z < lim) {
          calculate(x1z, x2z);
        }
      } else {
        while ((aVal*pow(x2z, 3)+qVal*pow(x2z, 2)+kVal*x2z+bVal) >= 0) {
          if (x2z < lim) {
            x2z+=0.1;
          } else {
            break;
          }
        }
        if (x2z < lim) {
          calculate(x2z, x1z);
        }
      }
      x1z = x2z;
    }
    break;
  case 5: 
    while (x2z < lim) {
      if ((aVal*pow(bVal, x2z)+qVal) <= 0) {
        while ((aVal*pow(bVal, x2z)+qVal) <= 0) {
          if (x2z < lim) {
            x2z+=0.1;
          } else {
            break;
          }
        }
        if (x2z < lim) {
          calculate(x1z, x2z);
        }
      } else {
        while ((aVal*pow(bVal, x2z)+qVal) >= 0) {
          if (x2z < lim) {
            x2z+=0.1;
          } else {
            break;
          }
        }
        if (x2z < lim) {
          calculate(x2z, x1z);
        }
      }
      x1z = x2z;
    }
    break;
  }
}


void calculate(float lowerLimit, float upperLimit) {
  float midpoint = (lowerLimit + upperLimit)/2;
  switch (equationState) {
  case 1:
    if (((aVal*sin((kVal*midpoint) + qVal)) + bVal)> 0.000001) {
      calculate(lowerLimit, midpoint);
    } else if (((aVal*sin((kVal*midpoint) + qVal)) + bVal) < -0.000001) {
      calculate(midpoint, upperLimit);
    } else {
      println("Zero is at " + midpoint);
      zeros.add(midpoint);
    }
    break;
  case 2:
    if (((aVal*cos((kVal*midpoint) + qVal)) + bVal) > 0.000001) {
      calculate(lowerLimit, midpoint);
    } else if (((aVal*cos((kVal*midpoint) + qVal)) + bVal) < -0.000001) {
      calculate(midpoint, upperLimit);
    } else {
      println("Zero is at " + midpoint);
      zeros.add(midpoint);
    }
    break;
  case 3:
    if ((aVal*pow(midpoint, 2)+kVal*midpoint+bVal) > 0.000001) {
      calculate(lowerLimit, midpoint);
    } else if ((aVal*pow(midpoint, 2)+kVal*midpoint+bVal) < -0.000001) {
      calculate(midpoint, upperLimit);
    } else {
      println("Zero is at " + midpoint);
      zeros.add(midpoint);
    }
    break;
  case 4:
    if ((aVal*pow(midpoint, 3)+qVal*pow(midpoint, 2)+kVal*midpoint+bVal)> 0.000001) {
      calculate(lowerLimit, midpoint);
    } else if ((aVal*pow(midpoint, 3)+qVal*pow(midpoint, 2)+kVal*midpoint+bVal) < -0.000001) {
      calculate(midpoint, upperLimit);
    } else {
      println("Zero is at " + midpoint);
      zeros.add(midpoint);
    }
    break;
  case 5:
    if ((aVal*pow(bVal, midpoint)+qVal)> 0.000001) {
      calculate(lowerLimit, midpoint);
    } else if ((aVal*pow(bVal, midpoint)+qVal) < -0.000001) {
      calculate(midpoint, upperLimit);
    } else {
      println("Zero is at " + midpoint);
      zeros.add(midpoint);
    }
    break;
  }
}

void mouseDragged() {
  if (mouseX < 700 && mouseY < 750) {
    if (!set) {
      ox = mouseX - xPos;
      oy = mouseY - yPos;
      set = true;
    }
    yPos = mouseY - oy;
    xPos = mouseX - ox;
  }
}

void mouseReleased() {
  if (mouseX < 700 && mouseY < 750) {
    if (set) {
      set = false;
    }
    yPos = mouseY - oy;
    xPos = mouseX - ox;
  }
}

void mouseWheel(MouseEvent event) {
  float e = event.getCount();
  if (e == -1) {
    if (c<10) { 
      c+=0.1;
    }
  } else {
    if (c>0.5) {
      c-=0.1;
    }
  }
}

class Button {
  float xPos, yPos, w, h;
  boolean clicked = false;
  String word;

  Button (float _xPos, float _yPos, float _w, float _h, String _word) {
    xPos = _xPos;
    yPos = _yPos;
    w = _w;
    h = _h;
    word = _word;
  }

  void update() {
    strokeWeight(2);
    stroke(50);
    rectMode(CENTER);
    if (mouseX > (xPos - w/2) && mouseX < (xPos + w/2) && mouseY > (yPos - h/2) && mouseY < (yPos + h/2)) {
      fill(#26C485);
      rect(xPos, yPos, w, h, 10);
      if (mousePressed && !clicked) {
        clicked = true;
        mousePressed = false;
      } else if (mousePressed && clicked) {
        clicked = false;
        mousePressed = false;
      }
    } else {
      fill(#6BA292);
      rect(xPos, yPos, w, h, 10);
    }
    fill(#FC7521);
    textSize(h/2);
    text(word, xPos, yPos + 7);
  }
}