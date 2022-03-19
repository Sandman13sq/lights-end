/// @desc 

// Inherit the parent event
event_inherited();

var coll = collision_circle(x, y, radius, obj_player, 0, 1);

if (!inradius)
{
	if (coll)
	{
		inradius = 1;
		global.g_playercharacter ^= 1;
		
		with obj_player
		{
			spriteset = spritesets[global.g_playercharacter];
		}
		
		image_index = !global.g_playercharacter;
		
		print(coll);
	}
}
else
{
	inradius = coll;
}


