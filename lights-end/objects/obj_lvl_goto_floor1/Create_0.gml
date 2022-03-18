/// @desc

// Inherit the parent event
event_inherited();

function SetBounds(x1, y1, x2, y2)
{
	x = x1;
	y = y1;
	image_xscale = x2-x1;
	image_yscale = y2-y1;
	
	return self;
}
