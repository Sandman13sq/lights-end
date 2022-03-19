/// @desc 

// Inherit the parent event
event_inherited();

function Update(ts)
{
	image_index = Modulo(image_index + ts/8, 8);
	hoverstep = Modulo(hoverstep + ts, 360);
	
	z = 10 + dsin(hoverstep)*4;
}

function OnPickup(player)
{
	if (isinfinite)
	{
		if (player.batteries < player.batteriesmax)
		{
			player.batteries = player.batteriesmax;
			SFXPlayAt(snd_battery);
		}
		
	}
	else
	{
		SFXPlayAt(snd_battery);
		player.batteries = min(player.batteries+1, player.batteriesmax);
		instance_destroy();
	}
}

