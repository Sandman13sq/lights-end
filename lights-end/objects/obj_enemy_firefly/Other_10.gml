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
		case(ST_Firefly.hover):
			if (PopStateStart())
			{
				visible = true;
				sprite_index = spr_firefly_float;
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
				// Walk in another direction
				if (walkcount < 3)
				{
					walkcount++;
					
					statestep = walktime * (0.5 + ORandom() / ORANDOMMAX);
					
					// Add random shift to walk angle
					movedirection = DirectionTo(p);
					movedirection += 100.0*(ORandom() / ORANDOMMAX - 0.5);
					image_xscale = sign( dcos(movedirection) );
				}
				else
				{
					SetState(ST_Firefly.hover);
					break;
				}
				
			}
			
			xspeed = Approach(xspeed, lengthdir_x(movespeed, movedirection), 0.5*ts);
			yspeed = Approach(yspeed, lengthdir_y(movespeed, movedirection), 0.5*ts);
			
			// Add movement
			x += xspeed * ts;
			y += yspeed * ts;
			
			image_index += random(2)*ts/3;
			
			z = 4 * (1.0+sin(hoverstep))*0.5;
			hoverstep = Modulo(hoverstep+0.1, 2*pi);
	
			break;
		
		// ===========================================================
		case(ST_Firefly.aim):
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
				SetState(ST_Firefly.aim_fire);
			}
			
			xspeed = Approach(xspeed, 0, 0.5*ts);
			yspeed = Approach(yspeed, 0, 0.5*ts);
			
			// Add movement
			x += xspeed * ts;
			y += yspeed * ts;
			
			break;
		
		// ===========================================================
		case(ST_Firefly.aim_fire):
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
					SetState(ST_Firefly.hover);
				}
			}
			
			xspeed = Approach(xspeed, 0, 0.5*ts);
			yspeed = Approach(yspeed, 0, 0.5*ts);
			
			// Add movement
			x += xspeed * ts;
			y += yspeed * ts;
			
			break;
		
		// ===========================================================
		case(ST_Firefly.kicked):
			if (PopStateStart())
			{
				zspeed = 16;
				
				sprite_index = spr_firefly_kicked;
				visible = true;
				
				ClearFlag(FL_Entity.shootable | FL_Entity.hostile | FL_Entity.kickable | FL_Entity.solid);
				SetFlag(FL_Entity.wallbounce);
				
				ShowScore(x, y, 10000, true);
				SetTimeStep(0.2);
				
				if ( !instance_exists(obj_fireflydefeat) ) 
				{
					instance_create_depth(0, 0, 0, obj_fireflydefeat);
				}
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
		
		// =========================================================================
		case(ST_Firefly.stagger_fall):
			if (PopStateStart())
			{
				statestep = 0;
				
				var dir = darctan2(yspeed, xspeed);
				xspeed = lengthdir_x(4, lastdamageparams[1]);
				yspeed = lengthdir_y(4, lastdamageparams[1]);
				zspeed = 10;
				
				sprite_index = spr_firefly_knockback;
				visible = true;
				
				ClearFlag(FL_Entity.shootable | FL_Entity.hostile | FL_Entity.kickable | FL_Entity.solid);
				SetFlag(FL_Entity.wallbounce);
				
				SFXPlayAt(snd_stagger, x, y);
				break;
			}
			
			zspeed += -0.5*ts;
			
			image_index += ts/4;
			if (abs(xspeed) > 1) {image_xscale = Polarize(xspeed);}
			
			// Add movement
			x += xspeed * ts;
			y += yspeed * ts;
			z += zspeed * ts;
			
			if (z <= 0 && zspeed < 0)
			{
				SetCameraShake(abs(zspeed * 2));
				
				z = 0;
				
				xspeed = Approach(xspeed, 0, 0.5*ts);
				yspeed = Approach(yspeed, 0, 0.5*ts);
				
				if (zspeed < -1)
				{
					zspeed = -zspeed/2;
				}
				else
				{
					SetState(ST_Firefly.stagger);
				}
			}
			break;
		
		// =====================================================================
		case(ST_Firefly.stagger):
			if (PopStateStart())
			{
				statestep = 300 + ORandom();
				z = 0;
				zspeed = 0;
				sprite_index = spr_firefly_stagger;
				SetFlag(FL_Entity.shootable | FL_Entity.kickable);
				ClearFlag(FL_Entity.hostile | FL_Entity.wallbounce | FL_Entity.solid);
				break;
			}
			
			image_index += ts/4;
			if (abs(xspeed) > 1) {image_xscale = Polarize(xspeed);}
			
			if (xshake == 0 && (statestep == 150 || statestep < 40))
			{
				xshake = 40;	
			}
			
			// Stand back up
			if (statestep > 0) {statestep = Approach(statestep, 0, ts);}
			else
			{
				SetState(ST_Firefly.hover);
				SetHealthMax(40);
				break;
			}
			
			xspeed = Approach(xspeed, 0, 0.2*ts);
			yspeed = Approach(yspeed, 0, 0.2*ts);
			
			// Add movement
			x += xspeed * ts;
			y += yspeed * ts;
			
			break;
	}
	
	EvaluateLineCollision();
	
	// Damage Flash
	SetDrawMatrix(0, 0, c_white, lastdamagestep/7);
}

function OnKick(angle)
{
	xspeed = lengthdir_x(10, angle);
	yspeed = lengthdir_y(10, angle);
	SetState(ST_Firefly.kicked);
}

function OnDamage(damage, angle, knockback)
{
	
}

function OnDefeat()
{
	SetState(ST_Firefly.stagger_fall);
}

