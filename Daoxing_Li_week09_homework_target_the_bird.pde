import ddf.minim.*;
int[] x=new int[0];
int[] y=new int[0];
color[] bgcolor=new color[0];
int[] Isanimal=new int[0];
PImage Animal;
int Score=0;
color background=color(random(255),random(255),random(255));
int Timer=0;
PImage Explosion;
AudioPlayer player;
Minim minim;//audio context
void setup()
{
  size(450,550);
  background(background);
  smooth();
  frameCount=0;
  minim = new Minim(this);
  player = minim.loadFile("Hammer.wav", 2048);
  int No=int(random(0,16));
  while(x.length!=0||y.length!=0||bgcolor.length!=0||Isanimal.length!=0)
  {
    x=shorten(x);
    y=shorten(y);
    bgcolor=shorten(bgcolor);
    Isanimal=shorten(Isanimal);
  }
  for(int i=60,j=160;i<450;i+=50+10+50)
  {
    for(;j<550;j+=50+10+50)
    {
      x=append(x,i);
      y=append(y,j);
      bgcolor=append(bgcolor,color(random(255),random(255),random(255)));
      Isanimal=append(Isanimal,0);
    }
    j=160;
  }
  for(int i=0;i<16;i++)
  {
    if(i==No){Isanimal[i]=1;break;}
  } 
}

void draw()
{
  if(Timer<0)
  {
    background(background);
    textAlign(CENTER,CENTER);
    textSize(30);
    fill(random(255),random(255),random(255));
    text("Game is Over!!!\nYour Score is "+Score,200,275);
  }else
  {
    if(frameCount%20==0)
    {
      background(background);
      DrawSquares(x,y,bgcolor,Isanimal,Animal);
      if(frameCount%50==0)
      {
        int No=int(random(0,16));
        while(x.length!=0||y.length!=0||Isanimal.length!=0)
        {
          x=shorten(x);
          y=shorten(y);
          Isanimal=shorten(Isanimal);
        }
        for(int i=60,j=160;i<450;i+=50+10+50)
        {
          for(;j<550;j+=50+10+50)
          {
            x=append(x,i);
            y=append(y,j);
            Isanimal=append(Isanimal,0);
          }
          j=160;
        }
        for(int i=0;i<16;i++)
        {
          if(i==No){Isanimal[i]=1;break;}
        }
      }
    }
    DrawTheCross(mouseX,mouseY);
    textAlign(CENTER,CENTER);
    textSize(30);
    fill(255);
    text("Score: "+Score,112.5,50);
    Timer=int(120-frameCount/60);
    text("Time: "+Timer+"S",337.5,50);
    textSize(12);
    text("            target and click the bird!",200,90);
    noCursor();
    
  } 
}
void mousePressed()
{
  if(Timer>0)
  {
    for(int i=0;i<16;i++)
    {
      if(mouseX>x[i]-50&&mouseX<x[i]+50&&mouseY>y[i]-50&&mouseY<y[i]+50&&Isanimal[i]==1)
      {
        Explosion=loadImage("explosion.png");
        imageMode(CENTER);
        image(Explosion,x[i],y[i],200,200);
        player.play();
        player.rewind();
        Score++;break;
      }
    }
  }
}

void DrawTheCross(int x,int y)
{
  noFill();
  stroke(0,255,0);
  ellipse(x,y,30,30);
  ellipse(x,y,15,15);
  line(x+15,y,x+35,y);
  line(x-15,y,x-35,y);
  line(x,y-15,x,y-35);
  line(x,y+15,x,y+35);
}

void DrawSquares(int[] x,int[] y,color[] bgcolor,int[] Isanimal,PImage Animal)
{
  for(int i=0;i<16;i++)
  {
    rectMode(CENTER);
    noStroke();
    fill(bgcolor[i]);
    rect(x[i],y[i],100,100);
    if(Isanimal[i]==1)
    {
      imageMode(CENTER);
      Animal = loadImage("angry-bird-icon.png");
      image(Animal,x[i],y[i],100,100);
    }
  }
}

