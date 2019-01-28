class Path {
    int[] path;
    int number;
    double fitness;
    
    // Constructs a random
    Path(int number) {
        //Randomly creates a path
        this.number = number;
        this.path = new int[places];
        
        boolean[] b = new boolean[places];
        b[0] = false;
        for (int i = 1; i < places - 1; i++) {
          b[i] = true;  
        }
        
        
        for (int i = 1; i < number - 1; i++) {
            int x = (int) random(number - i);
            int k = x;
            
            //Next true after x.
            while(!b[k % places]){
              k++;  
            }
         
            this.path[i] = k;
            b[k] = false;
        }
        
        this.path[0] = 0;
        this.path[places - 1] = places - 1;
        getWeight();
    }
    
    Path breed(Path path) {
      Path newPath = new Path(places);
      int rand = (int) random(places - 2);
      int len = (int) random(places / 2) + 1;
      if (rand + len > places){
        len = rand - places;
      }
      boolean[] b = new boolean[places];
      for (int i = 0; i < places; i++) {
        b[i] = true;  
      }
      
      // Fill in
      for (int i = rand; i < rand + len; i++){
        newPath.path[i] = this.path[i];
        b[this.path[i]] = false;
      }
      
      //
      int k = 0;
      for (int i = 0; i < places; i++) {
        if (b[path.path[i]]) {
          newPath.path[i] = path.path[i];
          b[path.path[i]] = false;
        }
      }
      
      // Mutate
      for (int i = 0; i < places - 1; i++) {
        if (random(1) < mutatePercent) {
            int toSwapWith =(int) random(places - 1) + 1;
            int p = newPath.path[i];
            newPath.path[i] = newPath.path[toSwapWith];
            newPath.path[toSwapWith] = p;
        }
      }
      
      newPath.getWeight();
      return newPath;
    }
    
    double getWeight() {
      boolean[] b = new boolean[places];
      for (int i = 0; i < places; i++) {
        b[i] = true;  
      }
      
      double sum = 0;
      for (int i = 1; i < places; i++){
          if (!b[path[i]]){
            this.fitness = 0;
            return 0;
          }
          b[path[i]] = false;
          sum += weights[path[i-1]][path[i]];
      }
      
      this.fitness = maxWeight - sum;
      return maxWeight - sum;
    }

    void draw() {
        for (int i = 1; i < places; i++) {
            line(positions[path[i-1]].x, positions[path[i-1]].y, positions[path[i]].x, positions[path[i]].y);
        }
    }
}
