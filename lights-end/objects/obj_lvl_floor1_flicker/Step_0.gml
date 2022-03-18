/// @desc

if (active)
{
	step = ApproachZero(step, TIMESTEP);
	
	var on = BoolStep(step, 15);
	
	with GetWorldByTag("floor1-tile-light") {visible = on;}
	with GetWorldByTag("floor1-tile-dim") {visible = !on;}
	
	if (step == 0)
	{
		CallPoll(tag);
		instance_destroy();	
	}
	
}
