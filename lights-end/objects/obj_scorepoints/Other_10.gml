/// @desc

// Inherit the parent event
event_inherited();

function Update(ts)
{
	yspeed = Approach(yspeed, 0, 0.95*ts);
	
	life = Approach(life, 0, ts);
	if (life == 0)
	{
		instance_destroy();	
	}
	
	z += yspeed;
}

function Draw()
{
	ShaderSet(shd_billboard);
	matrix_set(matrix_world, Mat4Translate(x, y-z, z));
	DrawSetAlign(1, 0);
	draw_text_transformed_color(4, 4, scorevalue, 2, 2, 0,
		LightsEndColor.dark, LightsEndColor.dark, LightsEndColor.dark, LightsEndColor.dark, 1);
	draw_text_transformed(0, 0, scorevalue, 2, 2, 0);
}

