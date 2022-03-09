/// @desc

function EntityFromTag(entry)
{
	var inst = noone;
	
	switch(entry.entity)
	{
		// Internals
		case("player1"): 
			inst = instance_create_depth(entry.x, entry.y, 0, obj_lvl_playerspawn1);
			break;
		//case("player2"): inst = instance_create_depth(entry.x, entry.y, 0, obj_lvl_playerspawn2); break;
		
		// World
		case("trigger"): 
			inst = instance_create_depth(entry.x, entry.y, 0, obj_lvl_trigger); 
			inst.image_xscale = entry.xradius;
			inst.image_yscale = entry.yradius;
			inst.x -= inst.sprite_width/2;
			inst.y -= inst.sprite_height/2;
			break;
		
		// Enemies
		case("ghost"): inst = instance_create_depth(entry.x, entry.y, 0, obj_enemy_ghostM); break;
		
	}
	
	return inst;
}


function LoadLevel(jsonpath)
{
	var b = buffer_load(filename_change_ext(jsonpath, ".json"));
	
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
			instance_create_depth(x, y, depth, obj_lvl_line).SetLine(
				e.x1, -e.y1, e.x2, -e.y2);
		}
		
		// Elements
		var elementjson = outjson.elements;
		n = array_length(elementjson);
		for (var i = 0; i < n; i++)
		{
			e = elementjson[i];
			EntityFromTag(e);
		}
		
	}
}



