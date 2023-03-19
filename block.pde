final class block{
    PVector position ;
    int blockWidth, blockHeight;
    boolean visible = true;
    
    block(int x, int y, int blockWidth, int blockHeight){
      position = new PVector(x,y);
      this.blockWidth = blockWidth;
      this.blockHeight = blockHeight;
    }

    void draw(){
      fill(#D37451);
      if(visible){
        rect(position.x, position.y, blockWidth, blockHeight) ;
      }
      
    }

}
