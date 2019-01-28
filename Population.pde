class Population{
  Path[] paths;
  int popSize;
  int best = 0;
  
  Population(int popSize){
    paths = new Path[popSize];
    for (int i = 0; i < popSize; i++) {
      paths[i] = new Path(places);  
    }
    this.popSize = popSize;
    breed();
  }
  
  void breed() {
    Path[] newPath = new Path[popSize];
    double fitSum = calculateWeights();
    for (int i = 0; i < popSize / 10; i++){
      newPath[i] = new Path(places);  
    }
    for (int i = popSize / 10; i < popSize; i++) {
      newPath[i] = selectParent(fitSum).breed(selectParent(fitSum));
    }
    newPath[0] = paths[best];
    paths = newPath;
  }
  
  void draw() {
    paths[best].draw();  
    textSize(26);
    for (int i = 0;i < places; i++){
      //text(paths[best].path[i] + "->", 10 + 60 * i, 800);
    }
  }
  
  double calculateWeights() {
    double max = 0;
    int maxID = 0;
    double fitSum = 0;
    for (int i = 0; i < popSize; i++) {
      double weight = paths[i].fitness;
      fitSum += weight;
      if (weight > max) {
        maxID = i;
        max = weight;
      }
    }
    this.best = maxID;
    return fitSum;
  }
  
  Path selectParent(double fitnessSum) {
    double sumTo = (double) random((float) fitnessSum);
    double sum = 0;
    for (int i = 0; i < popSize; i++){
      sum += paths[i].fitness;
      if (sum > sumTo) {
        return paths[i];  
      }
    }
    return null;
  }
}
