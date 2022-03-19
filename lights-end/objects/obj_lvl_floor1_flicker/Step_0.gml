/// @desc

if (active)
{
	step = ApproachZero(step, TIMESTEP);
	
	var on = BoolStep(step, 15);
	
	with GetWorldByTag("tile-light") {visible = on;}
	with GetWorldByTag("tile-dim") {visible = !on;}
	
	if irandom(4) > 0
	{
		SFXPlayAt(snd_flicker);
	}
	
	if (step == 0)
	{
		CallPoll(tag);
		instance_destroy();	
	}
}


