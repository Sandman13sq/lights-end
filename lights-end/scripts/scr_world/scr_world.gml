/// @desc

function EntityFromTag(entry)
{
	var inst = noone;
	
	switch(entry.entity)
	{
		// Internals
		case("player1"): inst = instance_create_depth(entry.x, entry.y, 0, obj_lvl_playerspawn1); break;
		//case("player2"): inst = instance_create_depth(entry.x, entry.y, 0, obj_lvl_playerspawn2); break;
		
		// Controls
		case("camerax"): inst = instance_create_depth(entry.x, entry.y, 0, obj_lvl_camerafollowX); break;
		case("cameray"): inst = instance_create_depth(entry.x, entry.y, 0, obj_lvl_camerafollowY); break;
		
		case("camerafocus"): inst = instance_create_depth(entry.x, entry.y, 0, obj_lvl_camerafocus); break;
		case("cameraright"): inst = instance_create_depth(entry.x, entry.y, 0, obj_lvl_camerafollowRight); break;
		case("cameraleft"): inst = instance_create_depth(entry.x, entry.y, 0, obj_lvl_camerafollowLeft); break;
		case("cameraup"): inst = instance_create_depth(entry.x, entry.y, 0, obj_lvl_camerafollowUp); break;
		
		case("cameraboundright"): inst = instance_create_depth(entry.x, entry.y, 0, obj_lvl_cameraboundRight); break;
		case("cameraboundup"): inst = instance_create_depth(entry.x, entry.y, 0, obj_lvl_cameraboundUp); break;
		case("cameraboundleft"): inst = instance_create_depth(entry.x, entry.y, 0, obj_lvl_cameraboundLeft); break;
		case("camerabounddown"): inst = instance_create_depth(entry.x, entry.y, 0, obj_lvl_cameraboundDown); break;
		
		case("trigger"): 
			inst = instance_create_depth(entry.x, entry.y, 0, obj_lvl_trigger)
				.SetBounds(entry.bounds[0], -entry.bounds[1], entry.bounds[2], -entry.bounds[3]);
			break;
		
		case("linedestroy"): inst = instance_create_depth(entry.x, entry.y, 0, obj_lvl_linedestroy); break;
		case("enemydefeat"): inst = instance_create_depth(entry.x, entry.y, 0, obj_lvl_enemydefeated); break;
		
		case("hideworld"): inst = instance_create_depth(entry.x, entry.y, 0, obj_lvl_hideworld); break;
		
		// Enemies
		case("ghost"): inst = instance_create_depth(entry.x, entry.y, 0, obj_lvl_ghost); break;
		case("retina"): inst = instance_create_depth(entry.x, entry.y, 0, obj_lvl_retina); break;
		case("firefly"): inst = instance_create_depth(entry.x, entry.y, 0, obj_lvl_firefly); break;
		
		// Events
		case("floor1flicker"): inst = instance_create_depth(entry.x, entry.y, 0, obj_lvl_floor1_flicker); break;
		
		case("darken"): inst = instance_create_depth(entry.x, entry.y, 0, obj_lvl_darken); break;
		
		case("tutorial"): inst = instance_create_depth(entry.x, entry.y, 0, obj_worldtutorial); break;
		case("batteryinf"): inst = instance_create_depth(entry.x, entry.y, 0, obj_battery); break;
		
		case("goto1"): inst = instance_create_depth(entry.x, entry.y, 0, obj_lvl_goto_floor1); break;
		case("goto2"): inst = instance_create_depth(entry.x, entry.y, 0, obj_lvl_goto_floor1); break;
		case("goto3"): inst = instance_create_depth(entry.x, entry.y, 0, obj_lvl_goto_floor1); break;
		
	}
	
	print(entry.entity)
	if (inst)
	{
		inst.SetTags(entry.tag, entry.trigger);
	}
	
	return inst;
}

function DefineLine(x1, y1, x2, y2)
{
	return instance_create_depth(0,0,0, obj_lvl_line).SetLine(x1, y1, x2, y2);
}

function LoadLevel(fpath)
{
	var b = buffer_load(filename_change_ext(fpath, ".json"));
	
	if (b >= 0)
	{
		var outjson = json_parse(buffer_read(b, buffer_text));
		buffer_delete(b);
		
		var e;
		var n;
		
		// Lines
		var linejson = outjson.lines;
		n = array_length(linejson);
		
		for (var i = 0; i < n; i++)
		{
			e = linejson[i];
			DefineLine(e.x1, -e.y1, e.x2, -e.y2).SetTags(e.tag, e.trigger);
		}
		
		// World
		var vba = LoadVBA(filename_change_ext(fpath, ".vba"));
		
		if (vba != -1)
		{
			for (var i = 0; i < vba.count; i++)
			{
				with instance_create_depth(x, y, 0, obj_worldvb)
				{
					tag = vba.names[i];
					vb = vba.vbs[i];
				}
			}
		}
		
		// Elements
		var elementjson = outjson.elements;
		n = array_length(elementjson);
		for (var i = 0; i < n; i++)
		{
			e = elementjson[i];
			repeat(1)
			EntityFromTag(e);
		}
		
	}
}

function CallPoll(triggertag)
{
	with obj_lvlElement {AnswerPoll(triggertag);}
	with obj_entity {AnswerPoll(triggertag);}
}

function GetWorldByTag(_tag)
{
	var out = noone;
	with obj_worldvb {if tag == _tag {out = id;}}
	return out;
}
