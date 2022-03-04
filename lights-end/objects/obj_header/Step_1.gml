/// @desc

if (hitstop > 0)
{
	hitstop = Approach(hitstop, 0, 1);
	TIMESTEP = 0;
}
else
{
	TIMESTEP = nexttimestep;
}

CURRENT_FRAME++;

