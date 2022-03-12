/// @desc

// Inherit the parent event
event_inherited();

function Update(ts)
{	
	life -= ts;
	if (life <= 0) {instance_destroy(); return;}
	
	var c;
	for (var i = 0; i < circcount; i++)
	{
		c = circ[i];
		c[0] += c[4];
		c[2] += c[5];
		c[3] *= 0.97;
		
		c[4] *= 0.9;
		c[5] *= 1.01;
	}
}

function Draw()
{
	var c;
	for (var i = 0; i < circcount; i++)
	{
		c = circ[i];
		DrawBillboardExt(spr_pixel, 0, 
			x + c[0], y + c[1], z + c[2], 
			c[3], c[3], 0, c[6], 1);
	}
}

