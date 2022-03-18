/// @desc 

// Inherit the parent event
event_inherited();

enum ST_Retina
{
	walk = 1,
	
	stagger_fall,
	stagger,
	defeat,
	kicked,
	
	aim,
	aim_fire,
	
	darken,
	chase,
}

SetFlag(FL_Entity.shootable | FL_Entity.solid);
SetState(ST_Retina.walk);

walktime = 120;
walkcount = 0;

movespeed = 2 + ORandom()/512;
movedirection = 0;

chasespeed = 5 + ORandom()/512;

radius = 64;

darkened = false;

SetHealthMax(20);
