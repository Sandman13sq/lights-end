/*
*/

function SetHitstop(frames)
{
	obj_header.hitstop = max(obj_header.hitstop, frames);
}

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