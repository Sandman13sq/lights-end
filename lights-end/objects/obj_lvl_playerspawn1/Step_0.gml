/// @desc

if (!instance_exists(obj_player))
{
	instance_create_depth(x, y, 0, obj_player);
}

obj_player.x = x;
obj_player.y = y;

instance_destroy();

