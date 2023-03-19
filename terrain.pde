final class terrain{
    ArrayList<ArrayList<block>> ter = new ArrayList<ArrayList<block>>();

    terrain(int blockWidth, int blockHeight){
      for(int i = 0; i<12; i++){
        ArrayList<block> blocks = new ArrayList<block>();
        int num = (int)random(1,8);
        for(int j = 1; j<=num; j++){
          int x = (4+i) * blockWidth;
          int y = displayHeight - j * blockHeight;
          block temp = new block(x,y, blockWidth, blockHeight);
          //System.out.println("block"+ j + ":" + x + " " + y);
          blocks.add(temp); 
        }
        ter.add(blocks);
      }
    }
    
    void draw(){
      for(int i = 0; i<ter.size();i++ ){
          for(int j = 0; j< ter.get(i).size(); j++){
              ter.get(i).get(j).draw();
          }
      }

    }



}
