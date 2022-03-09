/// @desc

if (active)
{
	if (instance_place(x, y, obj_player))
	{
		LevelAnswerPoll(tag);
		instance_destroy();
	}
}
