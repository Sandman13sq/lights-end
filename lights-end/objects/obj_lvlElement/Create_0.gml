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

function SetTags(_tag="", _trigger="")
{
	tag = _tag;
	trigger = _trigger;
	
	if (trigger != "")
	{
		active = false;
	}
}
