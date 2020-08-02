/*********************************************
 * OPL 12.10.0.0 Model
 * Author: IE400
 * Creation Date: 28 Tem 2020 at 17:20:37
 *********************************************/


//location part
range r1 = 0..29;
float Locations_X_Coordinate[r1]=...;
float Locations_Y_Coordinate[r1]=...;

//Storms part
range r2 = 0..19;

float Storms_X_Coordinate[r2] = ...;
float Storms_Y_Coordinate[r2] = ...;
float Storms_Radius[r2] = ...;

//road materials part
range r3 = 0..869;
string RM_roadMaterial[r3]=...;

tuple edge {
  int i;
  int j;
}

setof(edge) edges = {<i, j>| i,j in r1 : i != j};
float distances[edges];
float averageTime[edges];
int boolStorm[edges];
int count = 0;

execute {
    function getDistance(xi, xj) {
        return Math.sqrt(Math.pow(Locations_X_Coordinate[xi] - Locations_X_Coordinate[xj], 2) + Math.pow(Locations_Y_Coordinate[xi] - Locations_Y_Coordinate[xj], 2));
    }
    
    function getSlope(xi, xj) {
      	return (Locations_Y_Coordinate[xj] - Locations_Y_Coordinate[xi]) / (Locations_X_Coordinate[xj] - Locations_X_Coordinate[xi]);
    }
    
    function getBias(slope, xi, xj) {
      	return Locations_Y_Coordinate[xj] - slope * Locations_X_Coordinate[xj];
    }
    
    function isOverlapping(xi, xj, rk) {
      	var slope = getSlope(xi, xj);
      	var bias = getBias(slope, xi, xj);
      	var center_x = Storms_X_Coordinate[rk];
      	var center_y = Storms_Y_Coordinate[rk];
      	var radius = Storms_Radius[rk];
      	var delta = 4 * Math.pow(slope * (bias - center_y) - center_x, 2) - 4 * (Math.pow(slope, 2) + 1) * (Math.pow(bias - center_y, 2) + Math.pow(center_x, 2) - Math.pow(radius, 2));
      	return (delta >= 0);
    }
    
    for(var e in edges) {
    	distances[e] = getDistance(e.i, e.j);
    }
    
    for(var e in edges) {
      	boolStorm[e] = 1;  
    }
   
	//calculating
    for(var e in edges) {
      	 
         if(RM_roadMaterial[count] == "Asphalt" )
         {
           averageTime[e] = distances[e] / 100;
         }
         else if(RM_roadMaterial[count] == "Gravel")
         {
           averageTime[e] = distances[e] / 35;
         }
         else (RM_roadMaterial[count] == "Concrete")
         {
           averageTime[e] = distances[e] / 65;
         }
         count++;
    }
    
    for(var e in edges) {
      	for(var k in r2) {
      		if(isOverlapping(e.i, e.j, k)) {
      		  	boolStorm[e] = 0;
      		}
      	}
    } 
    
}

// decision variable
dvar boolean validPath[edges];
dvar float+ u[1..29];

// expressions
dexpr float TotalTime = sum(e in edges) averageTime[e] * validPath[e];

// objective function
minimize TotalTime;

//constraints
subject to {
  
 	forall(j in r1)
 	  flow_in:
 	  sum(i in r1: i != j && boolStorm[<i,j>] != 0) validPath[<i,j>] == 1;
 	  
 	forall(i in r1)
 	  flow_out:
 	  sum(j in r1: j != i && boolStorm[<i,j>] != 0) validPath[<i,j>] == 1;
 	  
 	forall(i in r1: i > 0, j in r1: j > 0 && j != i)
 	  subtour:
 	  u[i] - u[j] + 30 * validPath[<i,j>] <= 29;	  
}

