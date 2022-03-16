/// @desc

// Inherit the parent event
event_inherited();

function Update(ts)
{
	var xlev = LevKeyHeld(vk_right, vk_left);
	var ylev = LevKeyHeld(vk_down, vk_up);
	
	aimlock = keyboard_check( ord("Z") );
	
	grabbed = false;
	
	switch(state)
	{
		// =============================================================================
		case(ST_Player.control):
			zspeed = 0;
			
			grabenemyinst = noone;
			
			// Movement
			if (xlev != 0 || ylev != 0)
			{
				movedirection = Modulo(darctan2(-ylev, xlev), 360);
		
				if (!aimlock)
				{
					aimdirection = movedirection;
				}
				
				xspeed = Approach(xspeed, (movespeed+cankick*2) * dcos(movedirection), ts);
				yspeed = Approach(yspeed, (movespeed+cankick*2) * -dsin(movedirection), ts);
				
				if (cankick && (CURRENT_FRAME mod 6) == 0)
				{
					GFX_Rundust(x, y, z, FlipDirection(movedirection));
				}
		
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
				xspeed = Approach(xspeed, 0, ts);
				yspeed = Approach(yspeed, 0, ts);
			}
			
			// Schut
			if (refiredelay > 0) {refiredelay = Approach(refiredelay, 0, ts);}
			else if ( firebuffer > 0 && kickstep == 0 )
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
			
			// Aim Sprite
			if (aimlock)
			{
				timesinceshot = min(timesinceshot, 60);
			}
			
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
			
			// Kick sprite
			if (kickstep > 0)
			{
				kickstep = Approach(kickstep, 0, ts);
				
				if (kickstep > 0)
				{
					sprite_index = spriteset.kick;
					image_index = kickstep >= kicksteptime - 4;
					image_index = kickstep <= 10? 2: image_index;
				}
			}
			else
			{
				image_xscale = 1;	
			}
			
			// Fill pressure meter
			if (pressuremeter > 0)
			{
				pressuremeter = Approach(pressuremeter, 0, ts*0.1);	
			}
			
			break;
		
		// =============================================================================
		case(ST_Player.grab_ghost):
			grabbed = true;
			
			if (mashstep >= mashstepmax)
			{
				grabenemyinst.DoKick(movedirection);
				grabenemyinst = noone;
				
				kickstep = kicksteptime;
				mashstep = 0;
				SetState(ST_Player.control);
				break;
			}
			else
			{
				var _mash = (
					keyboard_check_pressed(vk_right) ||
					keyboard_check_pressed(vk_left) ||
					keyboard_check_pressed(vk_up) ||
					keyboard_check_pressed(vk_down)
					);
				mashstep += _mash? 13: -1;
				image_index += _mash;
			}
			
			// Wrestle
			if (pressuremeter < pressuremetermax)
			{
				sprite_index = spriteset.grab_ghost;
				image_index = Modulo(image_index + (pressuremeter/pressuremetermax)/3, 2);
				pressuremeter = Approach(pressuremeter, pressuremetermax, ts);
			}
			// Bite
			else
			{
				sprite_index = spriteset.grab_ghost;
				image_index = 2;
				
				xshake = 10;
				
				GFX_BloodSpray(x, y, 60, image_xscale);
				DoDamage(1);
			}
			
			xspeed = Approach(xspeed, 0, 0.3);
			yspeed = Approach(yspeed, 0, 0.3);
			break;
		
		// =============================================================================
		case(ST_Player.hurt):
			if (GetHitstop() == 0)
			{
				if (grabenemyinst)
				{
					grabenemyinst.NextState();
					grabenemyinst = noone;
				}
				
				if (iframes < iframestime) {state = ST_Player.control;}
			}
			
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
	if (healthpoints > 0)
	{
		var e;
		
		// Kick
		e = collision_circle(x, y, radius, obj_enemy, false, true);
		if (e)
		{
			if (cankick && e.HasFlag(FL_Entity.kickable))
			{
				e.DoKick(movedirection);
				kickstep = kicksteptime;
				image_xscale = Polarize(e.x-x);
				sprite_index = spriteset.kick;
			}
		}
		
		// Take Damage
		e = collision_circle(x, y, radius/2, obj_enemy, false, true);
		if (e)
		{
			if (
				iframes == 0 && 
				kickstep == 0 && 
				e.GetDamage() > 0 && 
				e.HasFlag(FL_Entity.hostile)
				)
			{
				sprite_index = spriteset.hurt;
				DoDamage(e.GetDamage());
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

function OnDamage(damage, angle, knockback)
{
	SetHitstop(20);
	
	mashstep = 0;
	pressuremeter = 0;
	
	if healthpoints > 0
	{
		SetState(ST_Player.hurt);
		iframes = iframestime;
		xspeed = lengthdir_x(knockback, angle);
		yspeed = lengthdir_y(knockback, angle);
	}
	else
	{
		
	}	
}

function OnDefeat()
{
	SetState(ST_Player.defeat0);
	zspeed = 7;
	xspeed = -lengthdir_x(4, movedirection);
	yspeed = -lengthdir_y(4, movedirection);
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
	
	// Skip draw on iframes
	if (GetHitstop() > 0 || BoolStep(iframes, 10) == 0)
	{
		DrawBillboard(shadowsprite, 0, xx, yy, 0, LightsEndColor.dark);
		DrawBillboardExt(sprite_index, image_index, xx, yy, z, image_xscale, image_yscale);
	}
	
	// Draw Mash Stick
	if (state == ST_Player.grab_ghost)
	{
		gpu_set_ztestenable(false);
		DrawBillboard(spr_mashstick, Modulo(pressuremeter/6, 4), 
			x-Polarize(x-obj_header.cameraposition[0])*140, y-20, 0);
		gpu_set_ztestenable(true);
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

function SetGrabInst(inst)
{
	grabenemyinst = inst;
}

function CanGrab()
{
	return iframes == 0 && healthpoints > 0 && grabenemyinst == noone && kickstep == 0;	
}
