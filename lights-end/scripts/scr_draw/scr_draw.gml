/// @desc

/*
	GM matrix index ref:
	[
		 0,  4,  8, 12,	| (x)
		 1,  5,  9, 13,	| (y)
		 2,  6, 10, 14,	| (z)
		 3,  7, 11, 15	|
		----------------
		(0) (0) (0)     
	]
*/

//*
function WorldToScreen(x, y, z, screenw, screenh, view_mat, proj_mat, outvec2 = [0,0])
{	
	return [x, y-z];
	
    var w = view_mat[2] * x + view_mat[6] * y + view_mat[10] * z + view_mat[14];
	
    var cx = proj_mat[8] + proj_mat[0] * (view_mat[0] * x + view_mat[4] * y + view_mat[8] * z + view_mat[12]) / w;
    var cy = proj_mat[9] + proj_mat[5] * (view_mat[1] * x + view_mat[5] * y + view_mat[9] * z + view_mat[13]) / w;
	
	outvec2[@ 0] = (0.5 + 0.5 * cx) * screenw;
	outvec2[@ 1] = (0.5 - 0.5 * cy) * screenh;
	return outvec2;
}

//*/

/*
function WorldToScreen(x, y, z, w, h, matview, matproj)
{
	var vec = matrix_transform_vertex(matview, x, y, z);
	vec = matrix_transform_vertex(matproj, vec[0], vec[1], vec[2]);
	
	return [
		((vec[0] + 1.0) * 0.5),
		-((vec[1] + 1.0) * 0.5)
	];
}
//*/

function WorldToScreenXY(x, y, z)
{
	return WorldToScreen(
		x, y, z, 960, 540,
		obj_header.matview, obj_header.matproj,
		);
}

function DrawShapeRectXY(x1, y1, x2, y2, color, alpha)
{
	draw_sprite_stretched_ext(spr_pixel, 0, x1, y1, x2-x1, y2-y1, color, alpha);
}

function DrawShapeRectWH(x, y, w, h, color, alpha)
{
	draw_sprite_stretched_ext(spr_pixel, 0, x, y, w, h, color, alpha);
}
