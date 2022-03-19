/// @desc

// Inherit the parent event
event_inherited();

active = true;

inradius = 0;

radius = 40;

function Draw3D()
{
	ShaderSet(shd_default);
	gpu_set_cullmode(cull_noculling);
	matrix_set(matrix_world, Mat4Translate(x,y,2));
	draw_sprite_ext(spr_playerchar, image_index, 0, 0, 1.2, 1.2, 0, c_white, 1);
	gpu_set_cullmode(cull_clockwise);
}

function Draw()
{
		
}

image_index = !global.g_playercharacter;