/// @desc

// Inherit the parent event
event_inherited();

active = 0;

function AnswerPoll(triggertag)
{
	if (triggertag == trigger)
	{
		active = 1;
	}
}

