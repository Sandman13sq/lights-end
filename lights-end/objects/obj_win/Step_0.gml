/// @desc 

if (
	obj_player.input.IPressed(InputIndex.fire) ||
	obj_player.input.IPressed(InputIndex.fire)
	)
{
	global.g_playercharacter ^= 1;
	game_restart();
}

