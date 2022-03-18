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
				
				SetFlag(FL_Entity.solid);
				ClearFlag(FL_Entity.kickable);
				
				break;
			}
			
			// Wait to change walk direction
			if (statestep > 0) {statestep = ApproachZero(statestep, ts);}
			else if (p)
			{
				// Reset walk count if player is far away
				if ( DistanceTo(p) >= 400 )
				{
					walkcount = 0;
				}
				
				// Walk in another direction
				if (walkcount < 3 && ORandom(3) != 0)
				{
					walkcount++;
					
					statestep = walktime * (0.5 + ORandom() / ORANDOMMAX);
					
					// Add random shift to walk angle
					movedirection = DirectionTo(p);
					movedirection += 100.0*(ORandom() / ORANDOMMAX - 0.5);
				
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
				zspeed = 7;
				
				sprite_index = darkened? spr_retinaD_kicked: spr_retina_kicked;
				visible = true;
				
				ClearFlag(FL_Entity.shootable | FL_Entity.hostile | FL_Entity.kickable | FL_Entity.solid);
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
		
		// =========================================================================
		case(ST_Retina.stagger_fall):
			if (PopStateStart())
			{
				statestep = 0;
				
				var dir = darctan2(yspeed, xspeed);
				xspeed = lengthdir_x(4, lastdamageparams[1]);
				yspeed = lengthdir_y(4, lastdamageparams[1]);
				zspeed = 10;
				
				sprite_index = darkened? spr_retinaD_stagger: spr_retina_stagger;
				visible = true;
				
				ClearFlag(FL_Entity.shootable | FL_Entity.hostile | FL_Entity.kickable | FL_Entity.solid);
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
		
		// =====================================================================
		case(ST_Retina.stagger):
			if (PopStateStart())
			{
				statestep = 300;
				z = 0;
				zspeed = 0;
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
				SetState(darkened? ST_Retina.chase: ST_Retina.walk);
				break;
			}
			
			xspeed = Approach(xspeed, 0, 0.2*ts);
			yspeed = Approach(yspeed, 0, 0.2*ts);
			
			// Add movement
			x += xspeed * ts;
			y += yspeed * ts;
			
			break;
		
		// ===========================================================
		case(ST_Retina.darken):
			if (PopStateStart())
			{
				statestep = 200;
				sprite_index = spr_retina_darken;
				break;
			}
			
			xshake = Wrap(xshake, 4, 10);
			
			image_index = BoolStep(statestep, 16);
			
			// Stand back up
			if (statestep > 0) {statestep = ApproachZero(statestep, ts);}
			else
			{
				SetState(ST_Retina.chase);
				break;
			}
			
			xspeed = Approach(xspeed, 0, 0.1*ts);
			yspeed = Approach(yspeed, 0, 0.1*ts);
			
			// Add movement
			x += xspeed * ts;
			y += yspeed * ts;
			break;
		
		// =========================================================
		case(ST_Retina.chase):
			if (PopStateStart())
			{
				sprite_index = spr_retina_chase;
				image_xscale = 1;
				statestep = 0;
				ClearFlag(FL_Entity.solid | FL_Entity.kickable);
				SetFlag(FL_Entity.hostile);
				break;
			}
			
			// Run towards player
			if (p)
			{
				// Add random shift to walk angle
				movedirection = DirectionTo(p);
			}
			
			xspeed = Approach(xspeed, lengthdir_x(chasespeed, movedirection), 0.2*ts);
			yspeed = Approach(yspeed, lengthdir_y(chasespeed, movedirection), 0.2*ts);
			
			// Add movement
			x += xspeed * ts;
			y += yspeed * ts;
			
			var o = Direction8(movedirection);
			image_index = Wrap(image_index + 1/5*(irandom(64)>0), o*6, o*6+6);
			break;
	}
	
	// Push away from other enemies
	PushOtherEnemies();
	
	EvaluateLineCollision();
	
	// Damage Flash
	SetDrawMatrix(0, 0, c_white, lastdamagestep/7);
}

P_Draw = Draw;
function Draw()
{
	P_Draw();
	
	// Aim Arrow Direction
	if (state == ST_Retina.aim_fire || state == ST_Retina.aim)
	{
		ShaderSet(shd_default);
		matrix_set(matrix_world, Mat4Translate(x, y, 4));
		
		draw_sprite_ext(
			spr_aimarrow, 1, 
			lengthdir_x(ARROWDISTANCE, movedirection), 
			lengthdir_y(ARROWDISTANCE, movedirection),
			1, 1, movedirection, c_fuchsia, 1
		);
	}
	
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
		ORandom( ceil(max(1, healthpoints * (darkened+1)) ) ) == 0
		)
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
	if (!darkened)
	{
		darkened = true;
		SetState(ST_Retina.darken);
	}
}