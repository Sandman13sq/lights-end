/// @desc

if (active)
{
	with obj_lvl_line
	{
		if (tag == other.tag) {instance_destroy();}
	}
	
	instance_destroy();
}
