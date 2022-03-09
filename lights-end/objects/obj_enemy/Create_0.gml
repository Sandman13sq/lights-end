/// @desc 

// Inherit the parent event
event_inherited();

damage = 1;
SetFlag(FL_Entity.hostile);
collisionfilter |= FL_CollisionFilter.enemy;

