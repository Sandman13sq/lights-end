/// @desc

if (active)
{
	if (timer > 0) {timer = ApproachZero(timer, TIMESTEP);}
	else
	{
		timer = timertime * (ORandom()/ORANDOMMAX);
		
		if instance_number(obj_enemy) <= 20
		{
			var p = obj_player;
			var xx = p.x;
			var yy = p.y;
		
			while ( point_distance(xx, yy, p.x, p.y) <= 40 )
			{
				xx = lerp(x-300, x+200, random(100)/100);
				yy = lerp(y-300, y+200, random(100)/100);
			}
		
			if ( choose(0, 1) == 0 )
			{
				var inst = instance_create_depth(xx, yy, depth, obj_enemy_ghostM);
				inst.lastdamageparams[1] = random(360);
				inst.SetState(ST_Ghost.knockback);
				inst.statestep = 60;
				inst.z = 400;
				inst.x = xx;
				inst.y = yy;
			}
			else
			{
				var inst = instance_create_depth(xx, yy, depth, obj_enemy_retina);
				inst.lastdamageparams[1] = random(360);
				inst.SetState(ST_Retina.stagger_fall);
				inst.statestep = 60;
				inst.z = 400;
				inst.x = xx;
				inst.y = yy;
			}
		}
	}
	
	
}
