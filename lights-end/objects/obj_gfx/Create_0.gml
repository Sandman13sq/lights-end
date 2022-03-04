/// @desc

depth = -10000;
z = 0;

lifemax = 20;
life = lifemax;

color = c_white;
alpha = 1;

function Update(ts)
{
	
}

function Draw()
{
	draw_sprite_ext(
		sprite_index, image_index,
		x, y-z, 
		image_xscale, image_yscale,
		image_angle,
		color, alpha
		);	
}
