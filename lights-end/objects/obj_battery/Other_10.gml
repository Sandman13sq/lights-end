/// @desc 

// Inherit the parent event
event_inherited();

function Update(ts)
{
	image_index = Modulo(image_index + ts/8, 8);
	hoverstep = Modulo(hoverstep + ts, 360);
	
	z = 10 + dsin(hoverstep);
}

function OnPickup(player)
{
	player.batteries = player.batteriesmax;
	
	if (!isinfinite)
	{
		instance_destroy();
	}
}

