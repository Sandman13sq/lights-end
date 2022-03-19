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

function SetBounds(x1, y1, x2, y2)
{
	x = x1;
	y = y1;
	image_xscale = x2-x1;
	image_yscale = y2-y1;
	
	return self;
}
