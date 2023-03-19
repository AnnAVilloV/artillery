final class tank {
    PVector position ;
    int tankWidth, tankHeight ;
    int moveIncrement ;
    color tankColor = color(255, 255, 255);
    boolean isHit = false;
    int lives = 3;
    
    barrel b;

    int startTime;

    

    tank(int x, int y, int tankWidth, int tankHeight, int moveIncrement,float angle){
        position = new PVector(x,y);
        this.tankWidth = tankWidth;
        this.tankHeight = tankHeight;
        this.moveIncrement = moveIncrement ;


        
        b = new barrel(position.x + tankWidth/2,position.y,angle);
    }

    //getter
    int getX() {return (int)position.x ;}
    int getY() {return (int)position.y ;}

    //setter
    void setColor(color c){
        this.tankColor = c;
    }

    void draw(){
       
        if(isHit){
          if(lives > 0){
             lives--;
             if(lives == 0){
               gameStatus = 1;
             }
          }
          isHit = false;
          startTime = millis();
        }else{
          fill(tankColor);
        }
        
        if (millis() - startTime < 500){
          fill(#E01705);
        } 
      
        circle(position.x + tankWidth/2, position.y, 40);
        rect(position.x, position.y, tankWidth, tankHeight) ;
        b.draw();
    }

    void moveLeft() {
        position.x -= moveIncrement ;

        b.start.x -= moveIncrement;
        b.end.x -= moveIncrement;

        if (position.x < 0) {
           position.x = 0 ;
           b.start.x = position.x + tankWidth/2;
           b.end.x = b.start.x + b.len * cos(radians(b.angle));
        }
        
        if(!round){
           if(leftHit()!= -1){
             position.x = ground.ter.get(leftHit()).get(0).position.x + tankWidth;
             b.start.x = position.x + tankWidth/2;
             b.end.x = b.start.x + b.len * cos(radians(b.angle));
           }
            if(tankHit()){
            position.x = tank1.position.x + tankWidth;
            b.start.x = position.x + tankWidth/2;
            b.end.x = b.start.x + b.len * cos(radians(b.angle));
          }
        }
        


       
    }
    void moveRight() {
        position.x += moveIncrement ;   
        b.start.x += moveIncrement;
        b.end.x += moveIncrement;
        
        if (position.x > displayWidth-tankWidth) {
          position.x = displayWidth-tankWidth ;
          b.start.x = position.x + tankWidth/2;
          b.end.x = b.start.x + b.len * cos(radians(b.angle));
        }
        
        if(round){
          if(rightHit()!=-1){
            position.x = ground.ter.get(rightHit()).get(0).position.x - tankWidth;
            b.start.x = position.x + tankWidth/2;
            b.end.x = b.start.x + b.len * cos(radians(b.angle));
          }
          if(tankHit()){
            position.x = tank2.position.x - tankWidth;
            b.start.x = position.x + tankWidth/2;
            b.end.x = b.start.x + b.len * cos(radians(b.angle));
          }
        }

          

  }  
  
  int rightHit(){
    float tankRight = position.x + tankWidth;
    float tankLeft = position.x;    
    for(int i = 0; i<12; i++){
      if(ground.ter.get(i).get(0).visible){
          float blockLeft = ground.ter.get(i).get(0).position.x;
          float blockRight = blockLeft + tankWidth;
          if(tankRight > blockLeft && tankLeft < blockRight){
            return i;
          }
      }
    }
    return -1;
    
  }

  int leftHit(){
    float tankLeft = position.x;
    float tankRight = position.x + tankWidth;
    for(int i=11;i>=0; i--){
      if(ground.ter.get(i).get(0).visible){
          float blockLeft = ground.ter.get(i).get(0).position.x;
          float blockRight = blockLeft + tankWidth;
          if(tankLeft<blockRight && tankRight>blockLeft){
            return i;
          }
      }
    }
    return -1;
  }
  
  boolean tankHit(){
    if(tank1.position.x + tank1.tankWidth > tank2.position.x){
        return true;
    }
    return false;
  }



}
