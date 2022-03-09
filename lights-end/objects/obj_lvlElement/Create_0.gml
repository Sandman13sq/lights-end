/// @desc

tag = "";
trigger = "";

function AnswerPoll(triggertag)
{
	if (trigger == triggertag)
	{
		var inst = EntityFromTag(triggertag);
		inst.x = x;
		inst.y = y;
		
		instance_destroy();
	}
}

function SetTrigger(triggertag)
{
	trigger = triggertag;
	if (trigger != "")
	{
		active = false;
	}
}
