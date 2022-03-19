/// @desc 

// Inherit the parent event
event_inherited();

enum ST_Firefly
{
	hover = 1,
	
	aim,
	aim_fire,
	
	darken,
	
	stagger_fall,
	stagger,
	kicked,
}

SetFlag(FL_Entity.hostile | FL_Entity.shootable | FL_Entity.solid);

walktime = 120;
walkcount = 0;

movespeed = 3;
movedirection = 0;

radius = 64;

hoverstep = 0;

SetHealthMax(250);
SetState(ST_Firefly.hover);
