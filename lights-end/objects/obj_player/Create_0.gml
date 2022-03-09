/// @desc

event_inherited();

#macro ARROWDISTANCE 64

direction = 0;
aimdirection = 0;
movedirection = 0;

movespeed = 6;

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
movingstep = 0;
movingsteptime = 30;

var s = random_get_seed();
randomize();
sprite_index = choose(spr_playerM_idle, spr_playerF_idle);
random_set_seed(s);

image_speed = 0;

x = 0; y = 0; z = 0;

LoadLevel("street");


