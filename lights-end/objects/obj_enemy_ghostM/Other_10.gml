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
				
				ClearFlag(FL_Entity.hostile | FL_Entity.kickable);
				SetFlag(FL_Entity.shootable | FL_Entity.solid);
				break;
			}
			
			// Wait to change walk direction
			if (statestep > 0) {statestep = Approach(statestep, 0, ts);}
			else if (p)
			{
				statestep = walktime * (0.5 + ORandom() / ORANDOMMAX);
		
				// Add random shift to walk angle
				movedirection = DirectionTo(p);
				movedirection += random_range(-15, 15);
				
				// Face player
				if abs( dcos(movedirection) ) > 0.1
				{
					image_xscale = sign( dcos(movedirection) );
				}
			}
			
			if ( DistanceTo(p) <= 80)
			{
				SetState(ST_Ghost.swipe0);
				break;
			}
			
			xspeed = Approach(xspeed, lengthdir_x(movespeed, movedirection), 0.5*ts);
			yspeed = Approach(yspeed, lengthdir_y(movespeed, movedirection), 0.5*ts);
			
			// Add movement
			x += xspeed * ts;
			y += yspeed * ts;
			
			image_index += random(2)*ts/13;
	
			break;
		
		// ===========================================================
		case(ST_Ghost.swipe0):
			if (PopStateStart())
			{
				visible = true;
				sprite_index = spr_ghostM_swipe;
				image_index = 0;
				statestep = 50;
				
				ClearFlag(FL_Entity.hostile, FL_Entity.kickable);
			}
			
			if (statestep > 0) {statestep = Approach(statestep, 0, ts);}
			else
			{
				SetState(ST_Ghost.swipe1);
				break;
			}
			
			xspeed = Approach(xspeed, 0, 0.5*ts);
			yspeed = Approach(yspeed, 0, 0.5*ts);
			
			// Add movement
			x += xspeed * ts;
			y += yspeed * ts;
	
			break;
		
		// ===========================================================
		case(ST_Ghost.swipe1):
			if (PopStateStart())
			{
				visible = true;
				sprite_index = spr_ghostM_swipe;
				image_index = 1;
				statestep = 70;
				
				instance_create_depth(x + 10 * image_xscale, y, 0, obj_enemy_swipe).image_xscale = image_xscale;
				
				ClearFlag(FL_Entity.hostile, FL_Entity.kickable);
			}
			
			if (statestep > 0) {statestep = Approach(statestep, 0, ts);}
			else
			{
				SetState(ST_Ghost.walk);
				break;
			}
			
			xspeed = Approach(xspeed, 0, 0.5*ts);
			yspeed = Approach(yspeed, 0, 0.5*ts);
			
			// Add movement
			x += xspeed * ts;
			y += yspeed * ts;
	
			break;
		
		// ===========================================================
		case(ST_Ghost.kicked):
			if (PopStateStart())
			{
				zspeed = 10;
				
				sprite_index = darkened? spr_ghostMD_defeat: spr_ghostM_defeat;
				visible = true;
				
				ClearFlag(FL_Entity.shootable | FL_Entity.hostile | FL_Entity.kickable | FL_Entity.solid);
				
				ShowScore(x, y, 200, true);
				break;
			}
			
			zspeed += -0.5 * ts;
			
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
				
				sprite_index = darkened? spr_ghostMD_defeat: spr_ghostM_defeat;
				visible = true;
				
				ClearFlag(FL_Entity.shootable | FL_Entity.hostile | FL_Entity.kickable | FL_Entity.solid);
				SetFlag(FL_Entity.wallbounce);
				break;
			}
			
			zspeed += -0.5 * ts;
			
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
				sprite_index = darkened? spr_ghostMD_down: spr_ghostM_down;
				
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
				SetState(darkened? ST_Ghost.chase: ST_Ghost.walk);
				break;
			}
			
			xspeed = Approach(xspeed, 0, 0.1*ts);
			yspeed = Approach(yspeed, 0, 0.1*ts);
			
			// Add movement
			x += xspeed * ts;
			y += yspeed * ts;
			
			break;
		
		// ===========================================================
		case(ST_Ghost.darken):
			if (PopStateStart())
			{
				statestep = 200;
				sprite_index = spr_ghostM_darken;
				break;
			}
			
			xshake = Wrap(xshake, 4, 10);
			
			image_index = BoolStep(statestep, 16);
			
			// Stand back up
			if (statestep > 0) {statestep = ApproachZero(statestep, ts);}
			else
			{
				SetState(ST_Ghost.chase);
				break;
			}
			
			xspeed = Approach(xspeed, 0, 0.1*ts);
			yspeed = Approach(yspeed, 0, 0.1*ts);
			
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
				ClearFlag(FL_Entity.hostile | FL_Entity.solid | FL_Entity.kickable);
				break;
			}
			
			// Wait to change walk direction
			if (p)
			{
				// Add random shift to walk angle
				movedirection = DirectionTo(p);
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
			
			xspeed = Approach(xspeed, lengthdir_x(chasespeed, movedirection), 0.3*ts);
			yspeed = Approach(yspeed, lengthdir_y(chasespeed, movedirection), 0.3*ts);
			
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
	PushOtherEnemies();
	
	EvaluateLineCollision();
	
	// Damage Flash
	SetDrawMatrix(0, 0, c_white, lastdamagestep/7);
}

function OnKick(angle)
{
	xspeed = lengthdir_x(10, angle);
	yspeed = lengthdir_y(10, angle);
	SetState(ST_Ghost.kicked);
}

function OnDamage(damage, angle, knockback)
{
	if (
		healthpoints > 0 && 
		state != ST_Ghost.down && 
		ORandom( ceil(max(1, healthpoints * (darkened+1)) ) ) == 0
		)
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
	GFX_Onyxplode(x, y, 0);
	instance_destroy();
}

function OnFlash(px, py)
{
	var dir = point_direction(px, py, x, y);
	
	DoDamage(1, dir, 10);
	SetState(ST_Retina.stagger_fall);
	
	xspeed = lengthdir_x(10, dir);
	yspeed = lengthdir_y(10, dir);
}

function Darken()
{
	if (state == ST_Ghost.walk)
	{
		darkened = true;
		SetState(ST_Ghost.darken);
	}
}

