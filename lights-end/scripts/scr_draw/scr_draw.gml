/// @desc

function DrawShapeRectXY(x1, y1, x2, y2, color, alpha)
{
	draw_sprite_stretched_ext(spr_pixel, 0, x1, y1, x2-x1, y2-y1, color, alpha);
}

function DrawShapeRectWH(x, y, w, h, color, alpha)
{
	draw_sprite_stretched_ext(spr_pixel, 0, x, y, w, h, color, alpha);
}
