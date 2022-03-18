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
	
	swipe0,
	swipe1,
	
	grab,
	grab_release,
	
	darken,
	chase,
}

SetFlag(FL_Entity.shootable | FL_Entity.solid);
SetState(ST_Ghost.walk);

walktime = 100;
movespeed = 2 + ORandom()/512;
chasespeed = 4 + ORandom()/256;
movedirection = 0;

radius = 32;

SetHealthMax(20);


