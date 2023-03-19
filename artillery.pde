//display all kinds of parameters (may need antankInitX1other class?)
//generate the 2 tanks and their shells, blocks(terrain)

final int tank_WIDTH_PROPORTION = 20,
          tank_HEIGHT_PROPORTION = 20,
          tank_INIT_X_PROPORTION = 10,
          tank_INCREMENT_PROPORTION = 100 ;
final int shell_WIDTH_PROPORTION = 8,
          shell_HEIGHT_PROPORTION = 8,
          shell_INCREMENT_PROPORTION = 100 ;
final int block_WIDTH_PROPORTION = 20,
          block_HEIGHT_PROPORTION = 20,
          block_INIT_X_PROPORTION = 10,
          block_INCREMENT_PROPORTION = 100 ;
final PVector gravity = new PVector(0f,0.1f) ;

//0 = ongoing, 1 = over, 2 = AI agent;
int gameStatus = 0;
terrain ground;
PVector wind;
int startTime;

tank tank1;
tank tank2;
shell shell1;
shell shell2;
float strength=10;
int sApply = 10;


//round = t, tank1; round = f, tank2
boolean round = true;
boolean firing = false;

boolean moveLeft1 = false;
boolean moveRight1 = false;

boolean moveLeft2 = false;
boolean moveRight2 = false;

boolean keyUP = false;
boolean keyDOWN = false;

boolean keyW = false;
boolean keyS = false;

void setup() {
fullScreen() ; 
  // initialise the tanks. 
    int tankWidth = displayWidth/tank_WIDTH_PROPORTION ;
    int tankHeight = displayHeight/tank_HEIGHT_PROPORTION ;
    int tankIncrement = displayWidth/tank_INCREMENT_PROPORTION ;    
    int tankInitX1 = displayWidth/tank_INIT_X_PROPORTION - tankWidth/2 ;
    int tankInitX2 = displayWidth- displayWidth/tank_INIT_X_PROPORTION - tankWidth/2;
    int tankInitY1 = displayHeight - tankHeight ;
    int tankInitY2 = displayHeight - tankHeight ;
    int blockWidth = displayWidth/block_WIDTH_PROPORTION ;
    int blockHeight = displayHeight/block_HEIGHT_PROPORTION ;
    
    ground = new terrain(blockWidth, blockHeight);
    wind = new PVector(random(-0.02,0.02),0);

    tank1 = new tank(tankInitX1, tankInitY1, tankWidth, tankHeight, tankIncrement,45);
    tank2 = new tank(tankInitX2, tankInitY2, tankWidth, tankHeight, tankIncrement,135);

    shell1 = new shell(tankInitX1,tankInitY1,0,0);
    shell2 = new shell(tankInitX2,tankInitY2,0,0);
    


    color color1 = color(237, 127, 167);
    color color2 = color(237, 188, 127);
    tank1.setColor(color1);
    tank2.setColor(color2);
    
    startTime = millis();


    size(400, 400);
    textSize(displayWidth/40);
}

void draw() {
      background(#2D2F8B) ;
      if(gameStatus == 1){
          delay(2000);
          float twidth = textWidth("Tank 1 Destroyed");
          float twidth2 = textWidth("Winner: Tank 2");
          
         if(tank1.lives == 0){
           text("Tank 1 Destroyed", displayWidth/2-twidth/2, 300);
           delay(1000);
           text("Winner: Tank 2", displayWidth/2-twidth2/2, 400); 
         }else{
           text("Tank 2 Destroyed", displayWidth/2-twidth/2, 300);
           delay(1000);
           text("Winner: Tank 1", displayWidth/2-twidth2/2, 400);
         }     
      } else {
          //terrain initializasion
          ground.draw();
          //wind set
          if(millis() - startTime > 10000){
            wind.x = random(-0.02,0.02);
            startTime = millis();
          }
          fill(255);
          text("Wind: " + wind.x, displayWidth*3/8, 200);
          
          if(gameStatus == 2){
            text("AI execution... ", displayWidth*3/8, 250);

          }

         
              if(keyW){
              strength = strength + 0.1;
              }else if(keyS){
              strength = strength - 0.1;
              if(strength<0)
                strength = 0;
              }
              sApply = (int)strength;
          

          
          
         text("Tank1", displayWidth*1/15,100); 
         text("lives: " + tank1.lives,displayWidth*1/15,150);
         text("angle: " + tank1.b.angle +"°",displayWidth*1/15,200);
    
         
         text("Tank2", displayWidth*3/4,100); 
         text("lives: " + tank2.lives,displayWidth*3/4,150);
         text("angle: " + tank2.b.angle +"°",displayWidth*3/4,200);
         
    
         
         if(round){
           text("Player 1 turn: ", displayWidth*1/15,450);
           text("Speed: "+sApply,displayWidth*1/15,500);
         }else{
            text("Player 2 turn: ", displayWidth*3/4,450);
            text("Speed: "+sApply,displayWidth*3/4,500);
         }
         
         
        
        if(round){  
            if(moveLeft1){
              tank1.moveLeft();
            }else if(moveRight1){
              tank1.moveRight();
            }
    
            if(keyUP){
              tank1.b.anticlockwise();
            }else if(keyDOWN){
              tank1.b.clockwise();
            }  
          
        }else{
            if(moveLeft2){
              tank2.moveLeft();
            }else if(moveRight2){
              tank2.moveRight();
            }
            
            if(keyUP){
              tank2.b.clockwise();
            }else if(keyDOWN){
              tank2.b.anticlockwise();
            }             
        }
        tank1.draw();
        tank2.draw();
        
        
        
        if (firing) {
           //render missile
            if (round && shell1.move()) {
               shell1.integrate();
               shell1.draw() ;
            }else if (!round && shell2.move()){
               shell2.integrate();
               shell2.draw();
            }
            else {
              round = !round;
              strength = 10;
               firing = false ;
              if(gameStatus == 2 && round){
                try{
                  wait(2000);
                }catch(Exception e){
                 e.printStackTrace();
                }
                fire();
              }
            }

        }
      
      
      
      
      
      }


    
}

void fire() {
  if (!firing) {

    if(round){   
        if(gameStatus == 2){
          int v = initVelocity();
          PVector startv = tank1.b.getDirection().mult(v);
          shell1.reset(tank1.b.end.x,tank1.b.end.y,startv,wind) ;          
        }else{
          PVector startv = tank1.b.getDirection().mult(sApply);
          shell1.reset(tank1.b.end.x,tank1.b.end.y,startv,wind) ;
        }


    }else{
        PVector startv = tank2.b.getDirection().mult(sApply);
        shell2.reset(tank2.b.end.x,tank2.b.end.y,startv,wind) ;
    }
    firing = true ;
  }
}

int initVelocity(){
    float angle = tank1.b.angle;

    float xDistance = tank2.position.x - tank1.position.x;
    //float yTarget = tank2.tankHeight;

    double v0d;
    v0d = sqrt(xDistance*mag(gravity.x,gravity.y)/(sin(radians(2*angle))));
    
    int v0i = (int)(1.3*v0d);
    return v0i;
}





void keyPressed(){
if(gameStatus != 1){
        if (key == ' ') {
          fire() ; 
          
          //round 要在hit后更改。
          //round = !round;
      }
      
      if(key == 'w'){
        if(!(gameStatus==2 && round))
          keyW = true;
      }
      if(key == 's'){
        if(!(gameStatus==2 && round))
          keyS = true;
      }

      if(key == 'u'){
        gameStatus = 2;
        if(round){
          delay(1000);
          fire();
        }
      }
      
      if (key == CODED) {
           switch (keyCode) {
             case UP : 
             if(!(gameStatus==2 && round))
               keyUP = true;
               break ;
             case DOWN : 
             if(!(gameStatus==2 && round))
               keyDOWN = true;
               break ;
           }
        }
      
    if(round){
        if (key == CODED) {
           switch (keyCode) {
             case LEFT :
             if(!(gameStatus==2 && round))
               moveLeft1 = true ;
               break ;
             case RIGHT :
             if(!(gameStatus==2 && round))
               moveRight1 = true ;
               break ;
             
           }
        }
    }else{
        if (key == CODED) {
           switch (keyCode) {
             case LEFT :
               moveLeft2 = true ;
               break ;
             case RIGHT :
               moveRight2 = true ;
               break ;
           }
        }
    }
  
  }
  

}

void keyReleased() {
if(gameStatus != 1){
          if(key == 'w'){
          keyW = false;
      }
      if(key == 's'){
          keyS = false;
      }
    
    if (key == CODED) {
           switch (keyCode) {
             case UP : 
               keyUP = false;
               break ;
             case DOWN : 
               keyDOWN = false;
               break ;
           }
    }
    
    if(round){
          if (key == CODED) {
             switch (keyCode) {
               case LEFT :
                 moveLeft1 = false ;
                 break ;
               case RIGHT :
                 moveRight1 = false ;
                 break ;
             }
          }
    }else{
          if (key == CODED) {
             switch (keyCode) {
               case LEFT :
                 moveLeft2 = false ;
                 break ;
               case RIGHT :
                 moveRight2 = false ;
                 break ;
             }
          }
    }
  }
}
