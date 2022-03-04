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
	}
}


function Draw()
{
	draw_self();
	draw_text(x, y, life);
	
}

function SetDirection(_dir)
{
	projdirection = _dir;
}
