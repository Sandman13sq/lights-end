/// @desc

if (active)
{
	var inst = instance_create_depth(x, y, depth, obj_enemy_retina);
	if (darkened) {inst.SetState(ST_Retina.chase);}
	instance_destroy();
}
