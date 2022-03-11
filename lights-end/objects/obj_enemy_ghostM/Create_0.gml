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
	grab
}

SetFlag(FL_Entity.hostile | FL_Entity.shootable);
SetState(ST_Ghost.walk);

walktime = 100;
movespeed = 1 + ORandom()/512;

SetHealthMax(10);


