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
		case(ST_Retina.walk):
			if (PopStateStart())
			{
				visible = true;
				sprite_index = spr_retina_walk;
				statestep = 0;
				walkcount = 0;
				
				SetFlag(FL_Entity.hostile);
				ClearFlag(FL_Entity.kickable);
				
				break;
			}
			
			// Wait to change walk direction
			if (statestep > 0) {statestep = ApproachZero(statestep, ts);}
			else if (p)
			{
				if (walkcount < 3)
				{
					walkcount++;
					
					statestep = walktime * (0.5 + ORandom() / ORANDOMMAX);
					
					// Add random shift to walk angle
					movedirection = point_direction(x, y, p.x, p.y);
					movedirection += random_range(-50, 50);
				
					// Face player
					if abs( dcos(movedirection) ) > 0.1
					{
						image_xscale = sign( dcos(movedirection) );
					}
				}
				else
				{
					SetState(ST_Retina.aim);
					break;
				}
				
			}
			
			xspeed = Approach(xspeed, lengthdir_x(movespeed, movedirection), 0.5*ts);
			yspeed = Approach(yspeed, lengthdir_y(movespeed, movedirection), 0.5*ts);
			
			// Add movement
			x += xspeed * ts;
			y += yspeed * ts;
			
			image_index += random(2)*ts/13;
	
			break;
		
		// ===========================================================
		case(ST_Retina.aim):
			if (PopStateStart())
			{
				sprite_index = spr_retina_aim;
				image_xscale = 1.0;
				statestep = 100;
				
				var dir = point_direction(x, y, 
					p.x + p.xspeed*20, 
					p.y + p.yspeed*20
					);
				dir = floor( Modulo(dir+45/2, 360)*8/360 );
				
				movedirection = dir*360/8;
				print(
					[point_direction(x, y, p.x, p.y), movedirection, dir]
				);
				image_index = (dir);
				break;
			}
			
			if (statestep > 0)
			{
				statestep = ApproachZero(statestep, ts);
				sprite_index = BoolStep(statestep, 4)? spr_retina_aim: spr_retina_aimflash;
			}
			else
			{
				SetState(ST_Retina.aim_fire);
			}
			
			xspeed = Approach(xspeed, 0, 0.5*ts);
			yspeed = Approach(yspeed, 0, 0.5*ts);
			
			// Add movement
			x += xspeed * ts;
			y += yspeed * ts;
			
			break;
		
		// ===========================================================
		case(ST_Retina.aim_fire):
			if (PopStateStart())
			{
				statestep = 10;
				walkcount = 0;
				
				sprite_index = spr_retina_aim;
				break;
			}
			
			if (statestep > 0)
			{
				statestep = ApproachZero(statestep, ts);
			}
			else
			{
				if (walkcount < 5)
				{
					statestep = 10;
					walkcount++;
					
					instance_create_depth(
						x + lengthdir_x(radius, movedirection), 
						y + lengthdir_y(radius, movedirection), 
						depth, obj_enemy_retina_ball).SetDirection(movedirection);
				}
				else
				{
					SetState(ST_Retina.walk);
				}
			}
			
			xspeed = Approach(xspeed, 0, 0.5*ts);
			yspeed = Approach(yspeed, 0, 0.5*ts);
			
			// Add movement
			x += xspeed * ts;
			y += yspeed * ts;
			
			break;
		
		// ===========================================================
		case(ST_Retina.kicked):
			if (PopStateStart())
			{
				zspeed = 13;
				
				sprite_index = spr_retina_kicked;
				visible = true;
				
				ClearFlag(FL_Entity.shootable | FL_Entity.hostile | FL_Entity.kickable);
				SetFlag(FL_Entity.wallbounce);
				
				ShowScore(x, y, 200, true);
				break;
			}
			
			zspeed += -0.5*ts;
			
			image_index += ts/3;
			image_xscale = -Polarize(xspeed);
			
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
			
		case(ST_Retina.stagger_fall):
			if (PopStateStart())
			{
				statestep = 0;
				
				var dir = darctan2(yspeed, xspeed);
				xspeed = lengthdir_x(4, lastdamageparams[1]);
				yspeed = lengthdir_y(4, lastdamageparams[1]);
				zspeed = 10;
				
				sprite_index = spr_retina_stagger;
				visible = true;
				
				ClearFlag(FL_Entity.shootable | FL_Entity.hostile | FL_Entity.kickable);
				SetFlag(FL_Entity.wallbounce);
				break;
			}
			
			zspeed += -0.5;
			
			image_index += ts/4;
			if (abs(xspeed) > 1) {image_xscale = Polarize(xspeed);}
			
			// Add movement
			x += xspeed * ts;
			y += yspeed * ts;
			z += zspeed * ts;
			
			if (z <= 0 && zspeed < 0)
			{
				SetCameraShake(abs(zspeed));
				
				z = 0;
				
				xspeed = Approach(xspeed, 0, 0.5*ts);
				yspeed = Approach(yspeed, 0, 0.5*ts);
				
				if (zspeed < -1)
				{
					zspeed = -zspeed/2;
				}
				else
				{
					SetState(ST_Retina.stagger);
				}
			}
			break;
		
		case(ST_Retina.stagger):
			if (PopStateStart())
			{
				z = 0;
				zspeed = 0;
				SetFlag(FL_Entity.shootable | FL_Entity.kickable);
				ClearFlag(FL_Entity.hostile | FL_Entity.wallbounce);
				break;
			}
			
			image_index += ts/4;
			if (abs(xspeed) > 1) {image_xscale = Polarize(xspeed);}
			
			xspeed = Approach(xspeed, 0, 0.2*ts);
			yspeed = Approach(yspeed, 0, 0.2*ts);
			
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
	SetState(ST_Retina.kicked);
}

function OnDamage(damage, angle, knockback)
{
	if (
		healthpoints > 0 && 
		state != ST_Retina.stagger_fall && 
		state != ST_Retina.stagger && 
		ORandom(4) == 0)
	{
		SetState(ST_Retina.stagger_fall);	
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

