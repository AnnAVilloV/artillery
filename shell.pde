final class shell {
    PVector position,velocity;
    //int moveIncrement;
    private static final int shellr = 20;
    private final PVector gravity = new PVector(0f,0.1f) ;
    private static final float DAMPING = .995f ;
    
    PVector wind = new PVector(0,0);


    shell(float px, float py, float vx, float vy){
        position = new PVector(px, py);
        velocity = new PVector(vx, vy);
    }
    
    void draw(){
          fill(255);
          circle(position.x,position.y,shellr);
          if(hitBlock() || hitTank()){
            resetStill();
          }
    }

    void reset(float x, float y,PVector startv, PVector wind) {
        position.x = x ;
        position.y = y ;
        velocity = startv.copy();
        this.wind = wind.copy();
        
    }
    void resetStill(){
      position.x = -100;
      position.y = -100;
      velocity.x = 0;
      velocity.y = 0;
    }
    



    
    boolean move() {
        if(position.y>=0 && position.y<=height && position.x >=0 && position.x <= width){
          return true;
        }else{
          return false;
        }
        //return (position.y -= moveIncrement) >= 0 ;
    }  

    void integrate(){
        velocity.add(gravity);
        velocity.add(wind);
        velocity.mult(DAMPING);
        position.add(velocity);
        //if ((position.x < 0) || (position.x > width)) velocity.x = -0.90*velocity.x ;
        //if ((position.y < 0) || (position.y > height)) velocity.y = -0.90*velocity.y ;   

    }

    //hit function, collision detect
  
    boolean hitBlock(){
      for(int i = 0; i<12; i++){
        ArrayList<block> temp = ground.ter.get(i);
        for(int j=0; j<temp.size();j++){
          if(temp.get(j).visible){
              float x = temp.get(j).position.x;
              float y = temp.get(j).position.y;
              float bw = temp.get(j).blockWidth;
              float bh = temp.get(j).blockHeight;
              PVector pos = new PVector(x-shellr/2, y-shellr/2);
              PVector crossPos = new PVector(x+bw+shellr/2, y+bh+shellr/2);
              if(position.x > pos.x && position.x < crossPos.x && position.y > pos.y && position.y < crossPos.y){
                //hit
                temp.get(j).visible = false;
                return true;
              }
          
          }
        }
      }
      return false;
    }
    
    
    boolean hitTank(){
     
          PVector pos2 = new PVector(tank2.position.x-shellr/2, tank2.position.y-shellr/2);
          PVector crossPos2 = new PVector(tank2.position.x + tank2.tankWidth + shellr/2, tank2.position.y + tank2.tankHeight + shellr/2);
          PVector pos1 = new PVector(tank1.position.x-shellr/2, tank1.position.y-shellr/2);
          PVector crossPos1 = new PVector(tank1.position.x + tank1.tankWidth + shellr/2, tank1.position.y + tank1.tankHeight + shellr/2);
          if(position.x > pos2.x && position.x < crossPos2.x && position.y > pos2.y && position.y < crossPos2.y){
             //hit tank2
             tank2.isHit = true;
             return true;
          }else if(position.x > pos1.x && position.x < crossPos1.x && position.y > pos1.y && position.y < crossPos1.y){
             //hit tank1
             tank1.isHit = true;
             return true;
          }else{
             return false;
          }
      
    
    }

}
