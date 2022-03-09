/// @desc

event_inherited();

function SetLine(_x1, _y1, _x2, _y2)
{
	x1 = _x1;
	y1 = _y1;
	x2 = _x2;
	y2 = _y2;
	
	x = x1;
	y = y1;
	
	image_xscale = (x2-x1);
	image_yscale = (y2-y1);
	
	normal = point_direction(x1, y1, x2, y2) + 90;
	
	return self;
}

x1 = bbox_left;
y1 = bbox_top;
x2 = bbox_right;
y2 = bbox_bottom;

normal = 0;

enemytransparent = false;
