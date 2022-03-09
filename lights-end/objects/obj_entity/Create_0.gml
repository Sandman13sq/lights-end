/// @desc Initialize Vars

#macro XSHAKETIME 16

enum FL_Entity
{
	shootable = 1 << 0,
	solid = 1<<1,
	hostile = 1<<2,
}

enum FL_Collision
{
	player = 1<<0,
	enemy = 1<<1,
}

vb_circle = LoadVB("unit_circle.vb");
vb_axis = LoadVB("unit_axis.vb");
vb_sprite = LoadVB("unit_sprite.vb");

entityindex = 0;
entityflag = 0;

tag = "";
trigger = "<no-trigger>";
active = true;

healthmax = 0;
healthpoints = 0;

damage = 0;

xshake = 0;

event_user(0);

xspeed = 0;
yspeed = 0;
zspeed = 0;

radius = 64;

state = 0;
statestart = 0;
statestep = 0;
z = 0;

autodepth = true;
depthoffset = 0;
collisionfilter = 0;

hitlist = ds_list_create();


