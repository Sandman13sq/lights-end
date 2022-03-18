/// @desc 

// Inherit the parent event
event_inherited();

SetFlag(FL_Entity.hostile | FL_Entity.shootable);

movespeed = 4;
movedirection = 0;

radius = 10;

z = 50;

SetHealthMax(0);

shadowsprite = spr_shadow32;

