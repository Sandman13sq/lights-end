/// @desc 

// Inherit the parent event
event_inherited();

visible = true;

function Update(ts)
{
	var p = instance_nearest(x, y, obj_player);
	
	switch(state)
	{
		// ===========================================================
		case(ST_Ghost.walk):
			if (PopStateStart())
			{
				visible = true;
				sprite_index = spr_ghostM;
				statestep = 0;
				
				SetFlag(FL_Entity.hostile);
				ClearFlag(FL_Entity.kickable);
				
				break;
			}
			
			// Wait to change walk direction
			if (statestep > 0) {statestep = Approach(statestep, 0, ts);}
			else if (p)
			{
				statestep = walktime * (0.5 + ORandom() / ORANDOMMAX);
		
				// Add random shift to walk angle
				movedirection = point_direction(x, y, p.x, p.y);
				movedirection += random_range(-15, 15);
				
				// Face player
				if abs( dcos(movedirection) ) > 0.1
				{
					image_xscale = sign( dcos(movedirection) );
				}
			}
			
			xspeed = Approach(xspeed, lengthdir_x(movespeed, movedirection), 0.5);
			yspeed = Approach(yspeed, lengthdir_y(movespeed, movedirection), 0.5);
			
			// Add movement
			x += xspeed * ts;
			y += yspeed * ts;
			
			image_index += random(2)*ts/13;
	
			break;
		
		// ===========================================================
		case(ST_Ghost.kicked):
			if (PopStateStart())
			{
				zspeed = 16;
				
				sprite_index = spr_ghostM_defeat;
				visible = true;
				
				ClearFlag(FL_Entity.shootable | FL_Entity.hostile | FL_Entity.kickable);
				
				ShowScore(x, y, 200, true);
				break;
			}
			
			zspeed += -0.5;
			
			// Add movement
			x += xspeed * ts;
			y += yspeed * ts;
			z += zspeed * ts;
			
			if (z <= 0 && zspeed < 0)
			{
				OnDefeat();
				return;
			}
			break;
			
		case(ST_Ghost.knockback):
			if (PopStateStart())
			{
				statestep = 0;
				
				var dir = darctan2(yspeed, xspeed);
				xspeed = lengthdir_x(4, lastdamageparams[1]);
				yspeed = lengthdir_y(4, lastdamageparams[1]);
				zspeed = 10;
				
				sprite_index = spr_ghostM_defeat;
				visible = true;
				
				ClearFlag(FL_Entity.shootable | FL_Entity.hostile | FL_Entity.kickable);
				SetFlag(FL_Entity.wallbounce);
				break;
			}
			
			zspeed += -0.5;
			
			// Add movement
			x += xspeed * ts;
			y += yspeed * ts;
			z += zspeed * ts;
			
			if (z <= 0 && zspeed < 0)
			{
				if (state == ST_Ghost.kicked)
				{
					OnDefeat();
					return;
				}
				
				SetCameraShake(7);
				SetState(ST_Ghost.down);
			}
			break;
		
		// ===========================================================
		case(ST_Ghost.down):
			if (PopStateStart())
			{
				statestep = 300;
				zspeed = 0;
				z = 0;
				sprite_index = spr_ghostM_down;
				
				SetHealthMax( max(healthmax/2, 1) );
				SetFlag(FL_Entity.shootable | FL_Entity.kickable);
				break;
			}
			
			if (xshake == 0 && (statestep == 150 || statestep < 40))
			{
				xshake = 40;	
			}
			
			// Stand back up
			if (statestep > 0) {statestep = Approach(statestep, 0, ts);}
			else
			{
				SetState(ST_Ghost.walk);
				break;
			}
			
			xspeed *= 0.9;
			yspeed *= 0.9;
			
			// Add movement
			x += xspeed * ts;
			y += yspeed * ts;
			
			break;
		
		// ===========================================================
		case(ST_Ghost.chase):
			if (PopStateStart())
			{
				sprite_index = spr_ghostMD_chase;
				statestep = 0;
				ClearFlag(FL_Entity.hostile);
				break;
			}
			
			// Wait to change walk direction
			if (p)
			{
				// Add random shift to walk angle
				movedirection = point_direction(x, y, p.x, p.y);
				movedirection += random_range(-15, 15);
				
				// Face player
				if abs( dcos(movedirection) ) > 0.5
				{
					image_xscale = sign( dcos(movedirection) );
				}
				
				// Grab Player
				if (p.CanGrab() && point_in_circle(p.x, p.y, x, y, radius))
				{
					p.SetState(ST_Player.grab_ghost);
					p.SetGrabInst(self);
					SetState(ST_Ghost.grab);
					p.xspeed = xspeed;
					p.yspeed = yspeed;
					p.image_xscale = Polarize(xspeed);
				}
			}
			
			xspeed = Approach(xspeed, lengthdir_x(chasespeed, movedirection), 0.1);
			yspeed = Approach(yspeed, lengthdir_y(chasespeed, movedirection), 0.1);
			
			// Add movement
			x += xspeed * ts;
			y += yspeed * ts;
			
			image_index = Modulo(image_index+random(2)*ts/4, image_number);
			
			break;
		
		// ===============================================================
		case(ST_Ghost.grab):
			visible = false;
			x = p.x;
			y = p.y;
			break;
		
		case(ST_Ghost.grab_release):
			if (GetHitstop() == 0)
			{
				visible = true;
				lastdamageparams[1] = FlipDirection(movedirection);
				SetState(ST_Ghost.knockback);
			}
			
			break;
	}
	
	// Push away from other enemies
	ds_list_clear(hitlist);
	var n = instance_place_list(x, y, obj_enemy, hitlist, false);
	var e;
	for (var i = 0; i < n; i++)
	{
		e = hitlist[| i];
		if ( point_distance(x, y, e.x, e.y) < 40 )
		{
			var d = point_direction(x, y, e.x, e.y);
			
			x -= lengthdir_x(1, d);
			y -= lengthdir_y(1, d);
			e.x += lengthdir_x(1, d);
			e.y += lengthdir_y(1, d);
		}
	}
	
	EvaluateLineCollision();
}

function OnKick(angle)
{
	xspeed = lengthdir_x(10, angle);
	yspeed = lengthdir_y(10, angle);
	SetState(ST_Ghost.kicked);
}

function OnDamage(damage, angle, knockback)
{
	if (healthpoints > 0 && state != ST_Ghost.down && ORandom(2) == 0)
	{
		SetState(ST_Ghost.knockback);	
	}
	else
	{
		xspeed = lengthdir_x(knockback, angle);
		yspeed = lengthdir_y(knockback, angle);
	}
	
	if (healthpoints == 0)
	{
		ShowScore(x, y, 100);	
	}
}

function OnDefeat()
{
	//PartParticlesCircle(PARTSYS, PType.onyxdebris, x, y, 64, 32, 0x200010, 20);
	GFX_Onyxplode(x, y, 0);
	instance_destroy();
}

