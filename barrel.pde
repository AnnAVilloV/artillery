final class barrel{
  
  PVector start,end;
  float len = 100;
  float angle = 45;
  color barrelColor = color(255, 255, 255);
  
  barrel(float sx, float sy, float startAngle){
    start = new PVector(sx, sy);
    angle = startAngle;
    float tempx = start.x + len * cos(radians(angle));
    float tempy = start.y - len * sin(radians(angle));
    end = new PVector(tempx,tempy);
  }
  
    void setColor(color c){
        this.barrelColor = c;
    }

  void draw(){
    
    strokeWeight(10);
    stroke(barrelColor);
    strokeCap(SQUARE);
    
    
    beginShape();
    vertex(start.x,start.y);
    vertex(end.x,end.y);
    endShape();
    strokeWeight(0);
  }
  
  void clockwise(){ 
    angle=angle-1;
    end.x = start.x + len * cos(radians(angle));
    end.y = start.y - len * sin(radians(angle));
  }
  
  void anticlockwise(){ 
    angle=angle+1;
    end.x = start.x + len * cos(radians(angle));
    end.y = start.y - len * sin(radians(angle));
  }
  
  PVector getDirection(){
    PVector tempend = end.copy();
    PVector tempstart = start.copy();
    PVector dir = tempend.sub(tempstart).add(tempend);
    
    dir = dir.normalize();
    return dir;
  }

  
  

}
