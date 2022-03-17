/// @desc

if (active)
{
	if (instance_place(x, y, obj_player))
	{
		CallPoll(tag);
		instance_destroy();
	}
}
