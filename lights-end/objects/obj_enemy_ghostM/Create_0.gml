/// @desc 

// Inherit the parent event
event_inherited();

enum ST_Ghost
{
	walk = 1,
	knockback,
	defeat,
	kicked,
	down,
	
	grab,
	grab_release,
	
	chase,
}

SetFlag(FL_Entity.hostile | FL_Entity.shootable);
SetState(choose(ST_Ghost.walk, ST_Ghost.chase));

walktime = 100;
movespeed = 2 + ORandom()/512;
chasespeed = 4 + ORandom()/512;
movedirection = 0;

radius = 64;

SetHealthMax(20);


