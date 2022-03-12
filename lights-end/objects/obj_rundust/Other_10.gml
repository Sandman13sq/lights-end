/// @desc

// Inherit the parent event
event_inherited();

function Update(ts)
{	
	life -= GetAbsoluteTimestep();
	if (life <= 0) {instance_destroy(); return;}
	
	size *= 0.98;
	
	x += ts*lengthdir_x(size/8, movedirection);
	y += ts*lengthdir_y(size/8, movedirection);
	z += ts*size/4;
}

function Draw()
{
	DrawBillboardExt(spr_pixel, 0, x, y, z, size, size, 0, c_ltgray, 1);
}

