/// @desc

// Inherit the parent event
event_inherited();

function Update(ts)
{
	var xlev = LevKeyHeld(vk_right, vk_left);
	var ylev = LevKeyHeld(vk_down, vk_up);
	
	aimlock = keyboard_check( ord("Z") );
	//infocus = keyboard_check( ord("Z") );
	
	if (xlev != 0 || ylev != 0)
	{
		movedirection = Modulo(darctan2(-ylev, xlev), 360);
		
		if (!aimlock)
		{
			aimdirection = movedirection;
		}
		
		xspeed = movespeed * dcos(movedirection) * (infocus == 0);
		yspeed = movespeed * -dsin(movedirection) * (infocus == 0);
		
		// Set sprite from direction
		if (aimdirection < 45-27.5) {image_index = 0;}	// Right
		else if (aimdirection < 45*2-27.5 ) {image_index = 1;}	// UpRight
		else if (aimdirection < 45*3-27.5 ) {image_index = 2;}	// Up
		else if (aimdirection < 45*4-27.5 ) {image_index = 3;}	// UpLeft
		else if (aimdirection < 45*5-27.5 ) {image_index = 4;}	// Left
		else if (aimdirection < 45*6-27.5 ) {image_index = 5;}	// DownLeft
		else if (aimdirection < 45*7-27.5 ) {image_index = 6;}	// Down
		else if (aimdirection < 45*8-27.5 ) {image_index = 7;}	// DownRight
	}
	else
	{
		xspeed = 0;
		yspeed = 0;
	}
	
	x += xspeed * ts;
	y += yspeed * ts;
	
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
	
	// Progress invicibility frames
	if (iframes > 0) {iframes = Approach(iframes, 0, ts);}
	// Take damage from enemies
	else
	{
		var e = instance_place(x, y, obj_enemy);
		if (e)
		{
			if (e.GetDamage() > 0 && e.HasFlag(FL_Entity.hostile))
			{
				iframes = iframestime;
				healthpoints = max(0, healthpoints-e.GetDamage());
				SetHitstop(5);
			}
		}
	}
}

function Draw()
{
	var w2s = WorldToScreenXY(x, y, z), xx = w2s[0], yy = w2s[1];
	
	// Draw sprite
	if (BoolStep(iframes, 10) == 0)
	{
		draw_sprite_ext(sprite_index, image_index, xx, yy, 1, 1, 0, c_white, 1);
	}
	
	// Aim Arrow Direction
	draw_sprite_ext(
		spr_aimarrow, aimlock, 
		xx + lengthdir_x(ARROWDISTANCE, aimdirection), 
		yy + lengthdir_y(ARROWDISTANCE, aimdirection) - 40,
		1, 1, aimdirection, c_yellow, 1
	);
	
	draw_text(16, 200, w2s);
	draw_text(16, 230, [x, y]);
}

