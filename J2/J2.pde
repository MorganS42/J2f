char q='a';

boolean mm=true; //max mode

int coneCount;
int goal;

boolean loop= false;
int tl=130; //track length

int[] cones;
ArrayList<Integer> dists = new ArrayList<Integer>();
ArrayList<int[]> sols = new ArrayList<int[]>();
int c = 0;
int n[];
void setup() {
  switch(q) {
    case 'a':
      coneCount=4;
      goal=6;
    break;
    case 'b':
      coneCount=5;
      goal=9;
    break;
    case 'c':
      coneCount=4;
      goal=7;
    break;
    case 'd':
      loop=true;
      coneCount=4;
      goal=12;
      tl=13;
    break;
  }
  
  //coneCount=7;
  //goal=18;
  
  if(mm) {
    int g=0;
    int h=0;
    while(true) {
      g++;     
      boolean done=false;
      h=h-1;
      
      while(!done) {
        //print(h+" ");
        h++;
        coneCount=g;
        goal=h;  
        
        cones = new int[coneCount];
        dists.clear();
        sols.clear();
        c = 0;
        n = new int[coneCount];
        
        for(int i=0; i<cones.length; i++) {
          n[i]=0;//pow(10,i);
        }
        
        boolean d=false;
        
        //int wow = round(pow(coneCount,goal));
        
        //int nn=0;
        
        while(!d) {
          //println(" ");
          
          /*nn++;
          
          if(nn%1000==0 && coneCount==7 && goal>=18) {
            println((100.0/wow*nn)+"% ");  
          }*/
          
          c=0;
          for(int i=0; i<cones.length; i++) {
            cones[i]=n[i]; 
          }
          dists.clear();
          for(int i=0; i<cones.length; i++) {
            for(int j=0; j<cones.length; j++) {
              if(i!=j) {
                dists.add(abs(cones[i]-cones[j]));
              }
            }  
          }
          
          
          n[coneCount-1]++;
          int mm=goal;
          if(loop) {
            mm=tl;  
          }
          for(int i=coneCount-1; i>0; i--) {
            if(n[i]>mm) {
              n[i]=0;
              n[i-1]++;  
            }
          }
          
          if(n[0]>mm) {
            d=true;  
          }
          
          for(int i=1; i<goal+1; i++) {
            if(dists.contains(i)) {
              c++;
            }
          }
          bs();
          if(c>=goal && check()) {
            sols.add(cones);
            d=true;
          }
        }
        
        if(sols.size()==0) {
          done=true;  
        }
      }
      println();
      println(g+" "+(h-1));
    }
  }
  else {
    cones = new int[coneCount];
    n = new int[coneCount];
    sols.clear();
    dists.clear();
    
    for(int i=0; i<cones.length; i++) {
      n[i]=0;//pow(10,i);
    }
    
    boolean d=false;
    
    while(!d) {
      //println(n);
      c=0;
      for(int i=0; i<cones.length; i++) {
        cones[i]=n[i]; 
      }
      dists.clear();
      for(int i=0; i<cones.length; i++) {
        for(int j=0; j<cones.length; j++) {
          if(i!=j) {
            dists.add(abs(cones[i]-cones[j]));
            if(loop) {
              dists.add(abs((tl+cones[i])-cones[j]));  
              dists.add(abs((tl+cones[j])-cones[i]));  
            }
          }
        }  
      }
      for(int i=1; i<goal+1; i++) {
        if(dists.contains(i)) {
          c++;
        }
      }
      bs();
      //if(cones[coneCount-1]==12) {
      if(c>=goal && check()) {
        sols.add(cones);
        println("");
        for(int i=0; i<cones.length; i++) {
          if(loop && cones[i]==tl) {
            println(tl*10+" or 0");  
          }
          else {
            println(cones[i]*10);
          }
        }
        //d=true;
      }
      
      n[coneCount-1]++;
      int mm=goal;
      if(loop) {
        mm=tl;  
      }
      for(int i=coneCount-1; i>0; i--) {
        if(n[i]>mm) {
          n[i]=0;
          n[i-1]++;  
        }
      }
      
      if(n[0]>mm) {
        d=true;  
      }
    }
    println("done");    
  }
}

void bs() { //bubble sort
  for(int i=0; i<cones.length; i++) {
    for(int j=0; j<cones.length-1; j++) {
      if(cones[j+1]<cones[j]) {
        int temp=cones[j];
        cones[j]=cones[j+1];
        cones[j+1]=temp;
      }
    }
  }
}

boolean check() {
  boolean temp=true;
  for(int i=0; i<cones.length; i++) {
    for(int[] ss : sols) {
      if(ss[i]!=cones[i]) {
        temp=false;    
      }
    }
  }
  return temp;
}