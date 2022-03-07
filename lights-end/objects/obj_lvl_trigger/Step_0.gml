/// @desc

if (active)
{
	if (instance_place(x, y, obj_player))
	{
		with obj_lvlElement
		{
			AnswerPoll(other.tag);
		}
		
		print("TRIGGERED")
		//instance_destroy();
	}
}
else
{
	if (trigger == "") {active = 1;}
}
