/// @desc

// Inherit the parent event
event_inherited();

function Update(ts)
{	
	life = Approach(life, 0, ts);
	if (life == 0)
	{
		instance_destroy();	
	}
	
	z += yspeed;
	
	image_index = image_number*power(1-life/lifemax, 0.5);
}

function Draw()
{
	DrawBillboardExt(sprite_index, image_index, 
		x, y, z, image_xscale, image_yscale, 0, 0, 1);
}

