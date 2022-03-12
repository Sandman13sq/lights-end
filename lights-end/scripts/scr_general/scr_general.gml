/*
*/

function print()
{
	var s = "";
	
	for (var i = 0; i < argument_count; i++)
	{
		s += string(argument[i]);
	}
	
	show_debug_message(s);
}

function msg()
{
	var s = "";
	for (var i = 0; i < argument_count; i++)
	{
		s += string(argument[i]);
	}
	
	show_message(s);
}

function SetHitstop(frames)
{
	obj_header.hitstop = max(obj_header.hitstop, frames);
}

function GetHitstop()
{
	return obj_header.hitstop;
}

function SetCameraState(state, focus=obj_header.camerafocus)
{
	obj_header.camerastate = state;
	obj_header.camerafocus = focus;
}

function SetCameraShake(frames)
{
	obj_header.screenshake = frames;
}

function ShowScore(x, y, value, usebonusmultiplier=false)
{
	if (obj_header.bonusstep > 0)
	{
		obj_header.bonusmultiplier += 1;
	}
	else
	{
		obj_header.bonusmultiplier = 1;
	}
	obj_header.bonusstep = obj_header.bonussteptime;
		
	value *= obj_header.bonusmultiplier;
	
	score += value;
	with instance_create_depth(x, y, 0, obj_scorepoints)
	{
		scorevalue = value;
	}
}

function GetAbsoluteTimestep()
{
	return obj_header.nexttimestep;
}
