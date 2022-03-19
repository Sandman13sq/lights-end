/// @desc

if (active)
{
	with obj_worldvb
	{
		if (tag == other.tag)
		{
			visible = true;	
			SFXPlayAt(snd_door, x, y);
		}
	}
	instance_destroy();
}
