/// @desc 

// Inherit the parent event
event_inherited();

function Update(ts)
{
	var p = instance_nearest(x, y, obj_player);
	
	switch(state)
	{
		// ===========================================================
		case(ST_Ghost.walk):
			if (PopStateStart())
			{
				statestep = 0;
				break;
			}
			
			// Wait to change walk direction
			if (statestep > 0) {statestep = Approach(statestep, 0, ts);}
			else if (p)
			{
				statestep = walktime * (0.5 + ORandom() / ORANDOMMAX);
		
				// Add random shift to walk angle
				var dirtoplayer = point_direction(x, y, p.x, p.y);
				dirtoplayer += random_range(-15, 15);
		
				xspeed = lengthdir_x(movespeed, dirtoplayer);
				yspeed = lengthdir_y(movespeed, dirtoplayer);
		
				// Face player
				if abs( dcos(dirtoplayer) ) > 0.1
				{
					image_xscale = sign( dcos(dirtoplayer) );
				}
			}
			
			// Add movement
			x += xspeed * ts;
			y += yspeed * ts;
	
			break;
		
		// ===========================================================
		case(ST_Ghost.defeat):
			if (PopStateStart())
			{
				statestep = 0;
				
				var dir = darctan2(yspeed, xspeed);
				xspeed = lengthdir_x(-3, dir);
				yspeed = -lengthdir_y(-3, dir);
				zspeed = 10;
				
				sprite_index = spr_ghostM_defeat;
				
				ClearFlag(FL_Entity.shootable | FL_Entity.hostile);
				break;
			}
			
			zspeed += -0.5;
			
			// Add movement
			x += xspeed * ts;
			y += yspeed * ts;
			z += zspeed * ts;
			
			if (z <= 0)
			{
				z = 0;
				
				// Change to go to footgrab state
				if ( ORandom() <= 64 ) 
				{
					SetState(ST_Ghost.down);
				}
				// Destroy
				else
				{
					instance_destroy();
				}
				return;
			}
			break;
		
		// ===========================================================
		case(ST_Ghost.down):
			if (PopStateStart())
			{
				statestep = 0;
				zspeed = 0;
				sprite_index = spr_ghostM_down;
				
				SetHealthMax( max(healthmax/2, 1) );
				SetFlag(FL_Entity.shootable);
				break;
			}
			
			xspeed *= 0.9;
			yspeed *= 0.9;
			
			// Add movement
			x += xspeed * ts;
			y += yspeed * ts;
			
			break;
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

function OnDefeat()
{
	if (state == ST_Ghost.down)
	{
		instance_destroy();
	}
	else
	{
		SetState(ST_Ghost.defeat);
	}
}

