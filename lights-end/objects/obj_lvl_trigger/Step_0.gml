/// @desc

if (active)
{
	var p = instance_place(x, y, obj_player)
	if (p)
	if (point_in_rectangle(p.x, p.y, bbox_left, bbox_top, bbox_right, bbox_bottom))
	{
		CallPoll(tag);
		instance_destroy();
	}
}
