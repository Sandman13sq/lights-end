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
		
		case("trigger"): 
			inst = instance_create_depth(entry.x, entry.y, 0, obj_lvl_trigger)
				.SetBounds(entry.bounds[0], -entry.bounds[1], entry.bounds[2], -entry.bounds[3]);
			break;
		
		case("linedestroy"): inst = instance_create_depth(entry.x, entry.y, 0, obj_lvl_linedestroy); break;
		case("enemydefeat"): inst = instance_create_depth(entry.x, entry.y, 0, obj_lvl_enemydefeated); break;
		
		// Enemies
		case("ghost"): inst = instance_create_depth(entry.x, entry.y, 0, choose(obj_enemy_ghostM, obj_enemy_retina)); break;
		
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
		
		// Elements
		var elementjson = outjson.elements;
		n = array_length(elementjson);
		for (var i = 0; i < n; i++)
		{
			e = elementjson[i];
			repeat(4)
			EntityFromTag(e);
		}
		
		with instance_create_depth(x, y, 0, obj_worldvb)
		{
			Load(filename_change_ext(fpath, ".vb"));	
		}
		
	}
}

function LevelAnswerPoll(triggertag)
{
	with obj_lvlElement {AnswerPoll(triggertag);}
	with obj_entity {AnswerPoll(triggertag);}
}


