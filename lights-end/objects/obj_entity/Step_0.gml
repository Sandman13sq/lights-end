/// @desc

if (!active) {return;}

Update(TIMESTEP);

if (lastdamagestep > 0)
{
	lastdamagestep = ApproachZero(lastdamagestep, TIMESTEP);	
}

if (xshake > 0)
{
	xshake = Approach(xshake, 0, TIMESTEP);
}

if (autodepth)
{
	depth = -y + depthoffset;	
}
