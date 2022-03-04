/// @desc

// Inherit the parent event
event_inherited();

function Update(ts)
{
	var p = instance_nearest(x, y, obj_player);
	
	if (p)
	{
		var dirtoplayer = point_direction(x, y, p.x, p.y);
		
		xspeed = lengthdir_x(movespeed, dirtoplayer);
		yspeed = lengthdir_y(movespeed, dirtoplayer);
		
		x += xspeed * ts;
		y += yspeed * ts;
	}
}

