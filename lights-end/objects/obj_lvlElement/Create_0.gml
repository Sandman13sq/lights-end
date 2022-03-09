/// @desc

tag = "";
trigger = "";
active = true;

function AnswerPoll(triggertag)
{
	if (trigger == triggertag)
	{
		// Do something
		active = true;
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
