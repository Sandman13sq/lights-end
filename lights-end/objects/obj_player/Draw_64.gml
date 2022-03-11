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

var pmeterw = 200, pmeterh = 10;
DrawShapeRectWH(32, yy+48, pmeterw, pmeterh, 0, 1);
DrawShapeRectWH(32, yy+48, pmeterw * pressuremeter/pressuremetermax, pmeterh, c_purple, 1);

draw_text(16, 100, [x, y]);
draw_text(16, 120, image_index);
draw_text(16, 140, [cankick, movingstep]);


