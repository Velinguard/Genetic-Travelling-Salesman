int places = 15;
double[][] weights = new double[places][places];
PVector[] positions = new PVector[places];
double[] best = new double[10000];
int generation = 0;
Population pop;
Path path;
PGraphics pg;
PGraphics graph;
double maxWeight;
int counter = 0;
float lastFrameY;

void setup() {
  // put setup code here
    size(1000, 1000);
    pg = createGraphics(600, 600);
    graph = createGraphics(600, 200);
    frameRate(200);
    maxWeight = 0;
    for (int i = 0; i < places; i++){
      double max = 0;
      for (int k = 0; k < places; k++) {
        double val = random(10) + 3;
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
        float x = 300 + ((float) cos(TWO_PI * (i * 0.1)) * 200);
        float y = 300 + ((float) sin(TWO_PI * (i * 0.1)) * 200);
        positions[i - 1] = new PVector(x, y);
    }
    pop = new Population(20);
}

void draw() {
    fill(0,255,0);
    pg.beginDraw();
    
    if (counter++ > 100) {
      pg.clear();
      pop.breed();
      best[generation++] = pop.paths[0].fitness;
      println("breeding...");
    }
    
    background(255);
 
    for (int i = 0; i < 10; i++) {
        ellipse(positions[i].x, positions[i].y, 20, 20);
        text(i, positions[i].x - 20 , positions[i].y);
    }
    pop.draw();
    pg.endDraw();
    
    graph.beginDraw();
    for (int i = 1; i < generation; i++){
      line((float) (i-1),(float) (maxWeight-best[i-1]), (float) i, (float) (maxWeight-best[i]));
    }
    graph.endDraw();    
    image(graph, 50, 50);
}
