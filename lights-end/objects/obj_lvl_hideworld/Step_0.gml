/// @desc

if (active)
{
	with obj_worldvb
	{
		if (tag == other.tag)
		{
			visible = false;	
		}
	}
	instance_destroy();
}
