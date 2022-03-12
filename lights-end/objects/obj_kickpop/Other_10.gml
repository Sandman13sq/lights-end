/// @desc

// Inherit the parent event
event_inherited();

function Update(ts)
{	
	life -= GetAbsoluteTimestep();
	if (life <= 0) {instance_destroy(); return;}
	
	radius = lerp(0, radiusmax*8, 1-life/lifemax);
	size = 16 * (life/lifemax);
}

function Draw()
{
	gpu_set_ztestenable(false);
	var angle = 0;
	for (var i = 0; i < circcount; i++)
	{
		DrawBillboardExt(spr_pixel, 0, 
			x + lengthdir_x(radius, angle), 
			y + lengthdir_y(radius, angle), 
			z, 
			size, size, 0, c_white, 1);
		angle += 360/circcount;
	}
	gpu_set_ztestenable(true);
}

