/// @desc

if (active)
{
	with obj_worldvb
	{
		if (tag == other.tag)
		{
			visible = true;	
		}
	}
	instance_destroy();
}
