/// @desc 

// Inherit the parent event
event_inherited();

enum ST_Firefly
{
	hover = 1,
	
	defeat,
	
	aim,
	aim_fire,
}

SetFlag(FL_Entity.hostile | FL_Entity.shootable);
SetState(ST_Retina.walk);

walktime = 120;
walkcount = 0;

movespeed = 2 + ORandom()/512;
movedirection = 0;

radius = 64;

SetHealthMax(20);
