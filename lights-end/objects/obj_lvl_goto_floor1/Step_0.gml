/// @desc

if (active)
{
	instance_create_depth(0,0,0,obj_roomtransition).targetroom = targetroom;
	instance_destroy();
}
