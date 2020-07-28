/*********************************************
 * OPL 12.10.0.0 Model
 * Author: Osmancan
 * Creation Date: 28 Tem 2020 at 17:20:37
 *********************************************/
//location part
range r1 = 2..31;
int Locations_No[r1]=...;
float Locations_X_Coordinate[r1]=...;
float Locations_Y_Coordinate[r1]=...;

//Storms part
range r2 = 3..22;
float Storms_X_Coordinate[r2] = ...;
float Storms_Y_Coordinate[r2] = ...;
float Storms_Radius[r2] = ...;
float Storms_Center[r2][0..1]= ...;

//road materials part
range r3 = 2..871;
int RM_from[r3] = ...;
int RM_to[r3]=...;
string RM_roadMaterial[r3]=...;



execute {
	
}