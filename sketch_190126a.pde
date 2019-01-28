int places = 20;
double mutatePercent = 0.5;
int populationSize = 2000;

double[][] weights = new double[places][places];
PVector[] positions = new PVector[places];
double[] best = new double[90000];
int generation = 0;
Population pop;
double maxWeight;
int counter = 0;
float lastFrameY;
int graphLooper = 0;

void setup() {
  // put setup code here
    size(1500, 1500);
    frameRate(200);
    maxWeight = 0;
    randomGrid(); //inCircle();
    pop = new Population(populationSize);
}

void randomGrid() {
  for (int i = 0; i < places; i++) {
    float x = 10 + (width - 20) / 50 * (int) (random(49) + 1);
    float y = 10 + (height - 20) / 50 * (int) (random(49) + 1);
    positions[i] = new PVector(x, y);
  }
  for (int i = 0; i < places; i++) {
    double max = 0;
    for (int k = 0; k < places; k++) {
      double val = Math.sqrt((positions[i].x - positions[k].x) * (positions[i].x - positions[k].x) + (positions[i].y - positions[k].y) * (positions[i].y - positions[k].y)); 
      if (val > max)
        max = val;
      weights[i][k] = val;   
    }
    maxWeight += max;
  }
}

void inCircle() {
    for (int i = 0; i < places; i++){
      double max = 0;
      for (int k = 0; k < places; k++) {
        double val = random(10) + 20;
        if (val > max)
          max = val;
        weights[i][k] = val;  
      }
      maxWeight += max;
      if (i < places - 1)
        weights[i][i + 1] = 1;
    }    
    for (int i = 1; i <= places; i++)
    {
        float z = 0.05; 
        float x = 300 + ((float) cos(TWO_PI * (i * z)) * 200);
        float y = 300 + ((float) sin(TWO_PI * (i * z)) * 200);
        positions[i - 1] = new PVector(x, y);
    }
}


void draw() {
    fill(0,255,0);
    
    if (counter++ > 100) {
      clear();
      pop.breed();
      best[generation++] = pop.paths[0].fitness;
      println("breeding... generation number " + generation);
    }
    
    background(255);
 
    for (int i = 0; i < places; i++) {
        ellipse(positions[i].x, positions[i].y, 20, 20);
        text(i, positions[i].x - 20 , positions[i].y);
    }
    drawGrid();
    pop.draw();
    for (int i = 1; i < generation; i++){
      if (i > width * graphLooper){
        graphLooper++;  
        //println(graphLooper);
      }
      line((float) (i - (width - 1) * graphLooper),(float) (maxWeight * graphLooper-best[i-1]), (float) i - (width - 1) * graphLooper + 1, (float) (maxWeight * graphLooper - best[i]) );
    }
}

void drawGrid() {
  // Vertical
    fill(250);
  for (int i = 0; i < 50; i++){
    fill(0);
    textSize(15);
    text(i, 0, height - 10 - i * (height - 20) / 50);
    text(i, width - 18, height - 10 - i * (height - 20) / 50);
    text(i, 10 + i * (width - 20) / 50,10);
    text(i, 10 + i * (width - 20) / 50,height - 10);
    stroke(126);
    line(10 + i * (width - 20) / 50, 10, 10 + i * (width - 20) / 50, height - 10);
    line(10, 10 + i * (height - 20) / 50, width - 10, 10 + i * (width - 20)/50);
  }
  stroke(0);
}
