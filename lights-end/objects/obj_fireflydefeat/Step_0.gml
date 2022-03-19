/// @desc 

if (alpha < 1)
{
	alpha = Approach(alpha, 1, TIMESTEP*0.02);
}
else
{
	room_goto(rm_win);
	instance_destroy();
}
