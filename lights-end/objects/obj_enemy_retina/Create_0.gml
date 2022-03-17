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
}

SetFlag(FL_Entity.shootable | FL_Entity.solid);
SetState(ST_Retina.walk);

walktime = 120;
walkcount = 0;

movespeed = 2 + ORandom()/512;
movedirection = 0;

radius = 64;

SetHealthMax(20);
