/// @desc Methods & Functions

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
			inst.DoDamage(damage);
			instance_destroy();
			return;
		}
		
	}
}


function Draw()
{
	draw_primitive_begin(pr_trianglelist);
	
	var w2s = WorldToScreenXY(x, y, z), xx = w2s[0], yy = w2s[1];
	
	var r = 10;
	var pts = [
		xx + lengthdir_x(r, projdirection-90),
		yy + lengthdir_y(r, projdirection-90),
		xx + lengthdir_x(r, projdirection),
		yy + lengthdir_y(r, projdirection),
		xx + lengthdir_x(r, projdirection+90),
		yy + lengthdir_y(r, projdirection+90),
		xx + lengthdir_x(r*2, projdirection+180),
		yy + lengthdir_y(r*2, projdirection+180),
	];
	
	draw_vertex_color(pts[0], pts[1], color, 1);
	draw_vertex_color(pts[2], pts[3], color, 1);
	draw_vertex_color(pts[4], pts[5], color, 1);
	
	draw_vertex_color(pts[4], pts[5], color, 1);
	draw_vertex_color(pts[6], pts[7], color, 1);
	draw_vertex_color(pts[0], pts[1], color, 1);
	
	draw_primitive_end();
}

function SetDirection(_dir)
{
	projdirection = _dir;
}

