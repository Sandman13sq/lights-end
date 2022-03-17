/// @desc 

if (active)
{
	var n = 0;
	with (obj_enemy) {n += 1;}
	
	if (n == 0)
	{
		print("Enemies Defeated!", [tag])
		CallPoll(tag);
		instance_destroy();
	}
}

