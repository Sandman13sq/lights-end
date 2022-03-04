/// @desc

// Inherit the parent event
event_inherited();

function Update(ts)
{
	var xlev = LevKeyHeld(vk_right, vk_left);
	var ylev = LevKeyHeld(vk_down, vk_up);
	
	infocus = keyboard_check( ord("Z") );
	
	if (xlev != 0 || ylev != 0)
	{
		aimdirection = Modulo(darctan2(-ylev, xlev), 360);
	
		xspeed = movespeed * dcos(aimdirection);
		yspeed = movespeed * -dsin(aimdirection);
		
		// Set sprite from direction
		if (aimdirection < 45-27.5) {image_index = 0;}	// Right
		else if (aimdirection < 45*2-27.5 ) {image_index = 1;}	// UpRight
		else if (aimdirection < 45*3-27.5 ) {image_index = 2;}	// Up
		else if (aimdirection < 45*4-27.5 ) {image_index = 3;}	// UpLeft
		else if (aimdirection < 45*5-27.5 ) {image_index = 4;}	// Left
		else if (aimdirection < 45*6-27.5 ) {image_index = 4;}	// DownLeft
		else if (aimdirection < 45*7-27.5 ) {image_index = 5;}	// Down
		else if (aimdirection < 45*8-27.5 ) {image_index = 0;}	// DownRight
	}
	else
	{
		xspeed = 0;
		yspeed = 0;
	}
	
	x += xspeed * ts * (infocus == 0);
	y += yspeed * ts * (infocus == 0);
	
	// Fire button
	if (keyboard_check(ord("X")))
	{
		firebuffer = firebuffertime;	
	}
	
	// Schut
	if (refiredelay > 0) {refiredelay = Approach(refiredelay, 0, ts);}
	else if ( firebuffer > 0 )
	{
		firebuffer = 0;
		refiredelay = refiretime;
		
		var inst = instance_create_depth(
			x + lengthdir_x(ARROWDISTANCE, aimdirection), 
			y + lengthdir_y(ARROWDISTANCE, aimdirection) - 16,
			depth, obj_projectile
			);
		inst.SetDirection(aimdirection);
	}
	
	if (firebuffer > 0) {firebuffer = Approach(firebuffer, 0, 1);}
	
}

function Draw()
{
	// Draw sprite
	draw_sprite_ext(sprite_index, image_index, x, y, 1, 1, 0, c_white, 1);
	
	// Aim Arrow Direction
	draw_sprite_ext(
		spr_aimarrow, infocus, 
		x + lengthdir_x(ARROWDISTANCE, aimdirection), 
		y + lengthdir_y(ARROWDISTANCE, aimdirection) - 16,
		1, 1, aimdirection, c_yellow, 1
	);
}

