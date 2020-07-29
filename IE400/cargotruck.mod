/*********************************************
 * OPL 12.10.0.0 Model
 * Author: Osmancan
 * Creation Date: 28 Tem 2020 at 17:20:37
 *********************************************/


//location part
range r1 = 0..29;

int Locations_No[r1]=...;
float Locations_X_Coordinate[r1]=...;
float Locations_Y_Coordinate[r1]=...;

//Storms part
range r2 = 0..19;

float Storms_X_Coordinate[r2] = ...;
float Storms_Y_Coordinate[r2] = ...;
float Storms_Radius[r2] = ...;
float Storms_Center[r2][0..1]= ...;

//road materials part
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
float c[edges];

execute {
    function getDistance(xi, xj) {
        return Math.sqrt(Math.pow(Locations_X_Coordinate[xi] - Locations_X_Coordinate[xj], 2) + Math.pow(Locations_Y_Coordinate[xi] - Locations_Y_Coordinate[xj], 2));
    }

    for(var e in edges) {
          c[e] = getDistance(e.i, e.j);
    }
   // writeln(" distance : ",getDistance(2, 3)); 

}