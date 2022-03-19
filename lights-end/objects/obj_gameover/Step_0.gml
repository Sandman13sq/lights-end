/// @desc 

if (alpha < 1)
{
	alpha = Approach(alpha, 1, TIMESTEP*0.005);
}
else if (alpha2 < 2)
{
	alpha2 = Approach(alpha2, 2, TIMESTEP*0.01);
}
else
{
	global.g_playercharacter ^= 1;
	game_restart();
}
