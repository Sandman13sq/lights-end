/// @desc Methods & Functions

event_inherited();

function Update(ts)
{
	x += lengthdir_x(projspeed, projdirection);
	y += lengthdir_y(projspeed, projdirection);
	
	// Progress life
	if (life > 0) {life = Approach(life, 0, ts);}
	else
	{
		instance_destroy();	
		return;
	}
	
	// Deal Damage
	var inst = instance_place(x, y, obj_enemy);
	if (inst)
	{
		if (inst.HasFlag(FL_Entity.shootable))
		{
			inst.DoDamage(damage, point_direction(x, y, inst.x, inst.y), 1);
			instance_destroy();
			return;
		}
		
	}
}

function Draw3D()
{
	DrawBillboard(spr_projectile, 0, x, y, z, c_yellow);
}

function SetDirection(_dir)
{
	projdirection = _dir;
}

