/// @desc

// Inherit the parent event
event_inherited();

function Update(ts)
{
	// Follow player
	var p = instance_nearest(x, y, obj_player);
	
	if (p)
	{
		var dirtoplayer = point_direction(x, y, p.x, p.y);
		
		xspeed = lengthdir_x(movespeed, dirtoplayer);
		yspeed = lengthdir_y(movespeed, dirtoplayer);
		
		x += xspeed * ts;
		y += yspeed * ts;
	}
	
	// Push away from other enemies
	ds_list_clear(hitlist);
	var n = instance_place_list(x, y, obj_enemy, hitlist, false);
	var e;
	for (var i = 0; i < n; i++)
	{
		e = hitlist[| i];
		if ( point_distance(x, y, e.x, e.y) < 40 )
		{
			var d = point_direction(x, y, e.x, e.y);
			
			x -= lengthdir_x(1, d);
			y -= lengthdir_y(1, d);
			e.x += lengthdir_x(1, d);
			e.y += lengthdir_y(1, d);
		}
	}
}

