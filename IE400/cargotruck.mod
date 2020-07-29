/*********************************************
 * OPL 12.10.0.0 Model
 * Author: Osmancan
 * Creation Date: 28 Tem 2020 at 17:20:37
 *********************************************/

//location variables
range r1 = 0..29;
int Locations_No[r1]=...;
float Locations_X_Coordinate[r1]=...;
float Locations_Y_Coordinate[r1]=...;

//Storms variables
range r2 = 0..19;
float Storms_X_Coordinate[r2] = ...;
float Storms_Y_Coordinate[r2] = ...;
float Storms_Radius[r2] = ...;
float Storms_Center[r2][0..1]= ...;

//road materials variables
range r3 = 0..869;
int RM_from[r3] = ...;
int RM_to[r3]=...;
string RM_roadMaterial[r3]=...;

subject to
{
 // minimize ...
}

tuple edge {
  int i;
  int j;
}

setof(edge) edges = {<i,j>| i,j in r1 : i != j};
float distances[edges];
float averageTime[edges];
int count = 0;

execute {
  	//funtion for calculating distance
    function getDistance(xi, xj) {
        return Math.sqrt(Math.pow(Locations_X_Coordinate[xi] - Locations_X_Coordinate[xj], 2) + Math.pow(Locations_Y_Coordinate[xi] - Locations_Y_Coordinate[xj], 2));
    }
	//getting distance and saving them as tuple
    for(var e in edges) {
          distances[e] = getDistance(e.i, e.j);
    }
    //calculating
    for(var e in edges) {
      	 
         if(RM_roadMaterial[count] =="Asphalt" )
         {
           averageTime[e] = distances[e]/100;
         }
         else if(RM_roadMaterial[count] =="Gravel")
         {
           averageTime[e] = distances[e]/35;
         }
         else (RM_roadMaterial[count] =="Concrete")
         {
           averageTime[e] = distances[e]/65;
         }
         count=count+1;
    }
   // writeln(" distance : ",getDistance(2, 3)); 

}