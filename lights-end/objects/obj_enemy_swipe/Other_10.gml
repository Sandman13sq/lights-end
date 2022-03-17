/// @desc 

// Inherit the parent event
event_inherited();

visible = true;

function Update(ts)
{
	if (statestep == 0)
	{
		instance_destroy();
		return;
	}
	
	image_index = image_number * (1.0-statestep/20.0);
	statestep = ApproachZero(statestep, ts);
}

