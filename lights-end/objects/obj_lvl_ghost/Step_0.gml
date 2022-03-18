/// @desc

if (active)
{
	var inst = instance_create_depth(x, y, depth, obj_enemy_ghostM);
	if (darkened) {inst.SetState(ST_Ghost.chase);}
	instance_destroy();
}
