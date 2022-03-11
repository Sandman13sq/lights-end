/// @desc

event_inherited();

#macro ARROWDISTANCE 64

enum ST_Player
{
	control,
	hurt, 
	
	grab_ghost,
	
	defeat0,	// Fall1
	defeat1,	// Bounce1
	defeat2,	// Fall2
	defeat3,	// Bounce2
}

spriteset = {
	idle : spr_playerM_idle,
	shoot : spr_playerM_shoot,
	hurt : spr_playerM_hurt,
	kick : spr_playerM_kick,
	knockdown : spr_playerM_knockdown,
	
	grab_ghost : spr_playerM_grab_ghost,
}

randomize();
if choose(0, 1)
spriteset = {
	idle : spr_playerF_idle,
	shoot : spr_playerF_shoot,
	hurt : spr_playerF_hurt,
	kick : spr_playerF_kick,
	knockdown : spr_playerF_knockdown,
	
	grab_ghost : spr_playerF_grab_ghost,
}

direction = 0;
aimdirection = 0;
movedirection = 0;
aimdirindex = 0;

movespeed = 6;
timesinceshot = 0;

infocus = false;
aimlock = false;

refiretime = 8;
refiredelay = 0;

firebuffer = 0;
firebuffertime = 5;

iframes = 0;
iframestime = 180;

healthmax = 3;
healthpoints = healthmax;

cankick = false;
kickstep = 0;
kicksteptime = 40;

movingstep = 0;
movingsteptime = 40;

collisionfilter |= FL_CollisionFilter.player;

image_speed = 0;

x = 0; y = 0; z = 0;

pressuremeter = 0;
pressuremetermax = 160;
mashstep = 0;
mashstepmax = 100;
grabenemyinst = noone;

LoadLevel("street");


