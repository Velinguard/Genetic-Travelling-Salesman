class Path {
    int[] path;
    int number;
    double fitness;
    
    // Constructs a random
    Path(int number) {
        //Randomly creates a path
        this.number = number;
        this.path = new int[places];
        ArrayList<Integer> arr = new ArrayList();
        for (int i = 1; i < number; i++)
          arr.add(i);
        for (int i = 1; i < number; i++) {
            int x = (int) random(arr.size());
            this.path[i] = arr.get(x);
            arr.remove(x);
        }
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
      for (int i = 0; i <places; i++) {
        b[i] = true;  
      }
      
      for (int i = rand; i < rand + len; i++){
        newPath.path[i] = this.path[i];
        b[this.path[i]] = false;
      }
      
      int k = 0;
      for (int i = 0; i < places; i++) {
        if (b[path.path[i]]) {
          newPath.path[i] = path.path[i];
        } /*
        if (i < rand || i > rand + len) {
          println(path.path[k]);
            while (k <= 10 && !b[path.path[k]]){
              k++;
              println("k is " + k);
              println(path.path[k]);
            }
            if (k <= 10) {
            b[path.path[k]] = false;
            newPath.path[i] = path.path[k];
            } else {
              newPath.path[  
            }
            
        }
*/        
      }
      newPath.getWeight();
      return newPath;
    }
    
    double getWeight() {
      double sum = 0;
      for (int i = 1; i < places; i++){
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
