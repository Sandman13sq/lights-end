/// @desc

// Inherit the parent event
event_inherited();

function Update(ts)
{
	var xlev = LevKeyHeld(vk_right, vk_left);
	var ylev = LevKeyHeld(vk_down, vk_up);
	
	aimlock = keyboard_check( ord("Z") );
	
	switch(state)
	{
		// =============================================================================
		case(ST_Player.control):
			zspeed = 0;
			image_xscale = 1;
			
			if (xlev != 0 || ylev != 0)
			{
				movedirection = Modulo(darctan2(-ylev, xlev), 360);
		
				if (!aimlock)
				{
					aimdirection = movedirection;
				}
		
				xspeed = (movespeed+cankick) * dcos(movedirection) * (infocus == 0);
				yspeed = (movespeed+cankick) * -dsin(movedirection) * (infocus == 0);
		
				// Set sprite from direction
				if (aimdirection < 45-27.5) {aimdirindex = 0;}	// Right
				else if (aimdirection < 45*2-27.5 ) {aimdirindex = 1;}	// UpRight
				else if (aimdirection < 45*3-27.5 ) {aimdirindex = 2;}	// Up
				else if (aimdirection < 45*4-27.5 ) {aimdirindex = 3;}	// UpLeft
				else if (aimdirection < 45*5-27.5 ) {aimdirindex = 4;}	// Left
				else if (aimdirection < 45*6-27.5 ) {aimdirindex = 5;}	// DownLeft
				else if (aimdirection < 45*7-27.5 ) {aimdirindex = 6;}	// Down
				else if (aimdirection < 45*8-27.5 ) {aimdirindex = 7;}	// DownRight
				
			}
			else
			{
				xspeed = 0;
				yspeed = 0;
			}
			
			// Schut
			if (refiredelay > 0) {refiredelay = Approach(refiredelay, 0, ts);}
			else if ( firebuffer > 0 )
			{
				firebuffer = 0;
				refiredelay = refiretime;
				
				timesinceshot = 0;
		
				var inst = instance_create_depth(
					x + lengthdir_x(ARROWDISTANCE, aimdirection), 
					y + lengthdir_y(ARROWDISTANCE, aimdirection) - 16,
					depth, obj_projectile
					);
				inst.SetDirection(aimdirection);
			}
			
			// Sprite
			if (timesinceshot <= 60) 
			{
				sprite_index = spriteset.shoot;
				image_index = aimdirindex*2 + (timesinceshot > 5);
			}
			else
			{
				sprite_index = spriteset.idle;	
				image_index = aimdirindex;
			}
			timesinceshot += ts;
			
			if (kickstep > 0)
			{
				kickstep = Approach(kickstep, 0, ts);
				
				sprite_index = spriteset.kick;
				image_index = kickstep >= kicksteptime - 4;
				image_index = kickstep <= 10? 2: image_index;
				image_xscale = Polarize(xspeed > 0);
			}
			
			break;
		
		// =============================================================================
		case(ST_Player.hurt):
			sprite_index = spriteset.hurt;
			if (iframes < iframestime) {state = ST_Player.control;}
			break;
		
		// =============================================================================
		case(ST_Player.defeat0):
		case(ST_Player.defeat2):
			sprite_index = spriteset.knockdown;
			image_index = zspeed > 0? 0: 1;
			zspeed -= 0.3*ts;
			
			image_xscale = Polarize(xspeed < 0);
			
			if (z <= 0 && zspeed < 0)
			{
				z = 0;
				zspeed = 0;
				state = state == ST_Player.defeat0? ST_Player.defeat1: ST_Player.defeat3;
				statestep = 5;
				
				SetCameraShake(10);
			}
			
			SetFlag(FL_Entity.wallbounce);
			break;
		
		case(ST_Player.defeat1):
			image_index = 2;
			if (statestep > 0) {statestep = Approach(statestep, 0, ts);}
			else
			{
				zspeed = 4;
				state = ST_Player.defeat2;
			}
			break;
		
		case(ST_Player.defeat3):
			image_index = 3;
			z = 0;
			zspeed = 0;
			xspeed = Approach(xspeed, 0, 0.1*ts);
			yspeed = Approach(yspeed, 0, 0.1*ts);
			break;
	}
	
	x += xspeed * ts;
	y += yspeed * ts;
	z += zspeed * ts;
	
	// Fire button
	if (firebuffer > 0) {firebuffer = Approach(firebuffer, 0, 1);}
	if (keyboard_check(ord("X")))
	{
		firebuffer = firebuffertime;	
	}
	
	// Progress invicibility frames
	if (iframes > 0) {iframes = Approach(iframes, 0, ts);}
	// Take damage from enemies
	else if (healthpoints > 0)
	{
		var e = instance_place(x, y, obj_enemy);
		if (e)
		{
			// Kick
			if (cankick && e.HasFlag(FL_Entity.kickable))
			{
				e.DoKick(movedirection);
				kickstep = kicksteptime;
			}
			// Take Damage
			else if (e.GetDamage() > 0 && e.HasFlag(FL_Entity.hostile))
			{
				sprite_index = spriteset.hurt;
				healthpoints = max(0, healthpoints-e.GetDamage());
				SetHitstop(15);
				
				if healthpoints > 0
				{
					state = ST_Player.hurt;
					iframes = iframestime;
				}
				else
				{
					state = ST_Player.defeat0;
					zspeed = 7;
					xspeed = -lengthdir_x(4, movedirection);
					yspeed = -lengthdir_y(4, movedirection);
				}
			}
		}
	}
	
	// Running
	cankick = movingstep == 0 && !aimlock;
	if (aimlock || (xlev==0 && ylev==0)) {movingstep = movingsteptime;}
	else
	{
		movingstep = Approach(movingstep, 0, ts);	
	}
	
	EvaluateLineCollision();
}

function Draw3D()
{
	var xx = x, yy = y;
	
	
}

function Draw()
{
	var xx = x, yy = y;
	
	if (xshake > 0)
	{
		xx += 3 * Polarize(BoolStep(xshake, 4));
	}
	
	if (BoolStep(iframes, 10) == 0)
	{
		DrawBillboard(spr_shadow, 0, xx, yy, 0, LightsEndColor.dark);
		DrawBillboardExt(sprite_index, image_index, xx, yy, z, image_xscale, image_yscale);
	}
	
	// Aim Arrow Direction
	ShaderSet(shd_default);
	matrix_set(matrix_world, Mat4Translate(xx, yy, 4));
	
	draw_sprite_ext(
		spr_aimarrow, aimlock, 
		lengthdir_x(ARROWDISTANCE, aimdirection), 
		lengthdir_y(ARROWDISTANCE, aimdirection),
		1, 1, aimdirection, c_yellow, 1
	);
}

