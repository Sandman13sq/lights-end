/// @desc 

// Inherit the parent event
event_inherited();

function Update(ts)
{
	image_index = Modulo(image_index + ts/4, image_number);
	hoverstep = Modulo(hoverstep + ts, 360);
	
	z = 10 + dsin(hoverstep);
}

function OnPickup(player)
{
	player.AddCamera();
	
	if (!isinfinite)
	{
		instance_destroy();
	}
	
}

