/// @desc

var xx = 64, yy = 64, xsep = 64;

for (var i = healthmax-1; i >= 0; i--)
{
	draw_sprite(spr_hp_case, 0, xx+xsep*i, yy);
	
	if (i < healthpoints)
	{
		draw_sprite(spr_hp_heart, 0, xx+xsep*i, yy);
	}
}

draw_text(16, 16, healthpoints);

