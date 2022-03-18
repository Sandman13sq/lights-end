/// @desc

DrawSetAlign(0, 0);

var xx = 64, yy = 64, xsep = 64;

for (var i = healthmax-1; i >= 0; i--)
{
	draw_sprite(spr_hp_case, 0, xx+xsep*i, yy);
	
	if (i < healthpoints)
	{
		draw_sprite(spr_hp_heart, 0, xx+xsep*i, yy);
	}
}

// Pressure meter
yy += 48;
var pmeterw = 200, pmeterh = 16;
DrawShapeRectWH(32, yy, pmeterw, pmeterh, 0, 1);
DrawShapeRectWH(32, yy, pmeterw * pressuremeter/pressuremetermax, pmeterh, c_purple, 1);

// Danger Warning
if (pressuremeter/pressuremetermax >= 0.5 && BoolStep(pressuremeter, 10))
{
	draw_text(32, yy + pmeterh + 4, "DANGER!");
}


// Draw Score
DrawSetAlign(1, 0);
var _s = string(score);
_s = string_repeat("0", 8-string_length(_s)) + _s;
draw_text(GUI_W/2, 40, "SCORE: " + _s);


if (DEBUG > 0)
{
	draw_text(16, 200, [x, y]);
	draw_text(16, 220, image_index);
	draw_text(16, 240, [cankick, movingstep]);
}

