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

// Generate sprite matrices
#macro DRAWSCALE3D 0.02
#macro MAT4SPRITE global.g_mat4sprite
#macro UVSSPRITE global.g_uvsprite
var spr = 0, n;
var imagemats, uvbounds;
var s = DRAWSCALE3D;

MAT4SPRITE = array_create(128);
UVSSPRITE = array_create(128);

while (sprite_exists(spr))
{
	n = sprite_get_number(spr);
	imagemats = array_create(n);
	uvbounds = array_create(n);
	
	var xx, yy, ww, hh, uvs;
	
	xx = -sprite_get_xoffset(spr);
	yy = -sprite_get_yoffset(spr);
	ww = sprite_get_width(spr);
	hh = sprite_get_height(spr);
	
	//print([sprite_get_name(spr), xx, yy, ww, hh])
	
	for (var i = 0; i < n; i++)
	{
		//xx = 0;
		//yy = 0;
		
		uvs = sprite_get_uvs(spr, i);
		
		imagemats[i] = [
			(ww)*s, 0, 0, 0,
			0, (hh)*s, 0, 0,
			0, 0,  1, 0,
			(xx+20)*s, (yy+40)*s, 0, 1
			];
		
		uvbounds[i] = [0,0,1,1];
	}
	
	MAT4SPRITE[spr] = imagemats;
	UVSSPRITE[spr] = uvbounds;
	spr++;	
}

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

/*
	Sprite Transform
	Billboard
	Location
*/

function Mat4Sprite(sprite_index, image_index, x, y, z)
{
	var spritemat = sprite_index >= 0? MAT4SPRITE[sprite_index][image_index]: matrix_build_identity();
	var s = DRAWSCALE3D;
	
	return matrix_multiply(
		matrix_multiply(
			spritemat, // Transform panel to sprite size
			obj_header.matbillboard,	// Rotate towards Camera
			),	
		matrix_build(x*s, y*s, z*s, 0, 0, 0, 1, 1, 1),	// Move model
		);
}

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

function Mat4Translate(x, y, z) {return matrix_build(x, y, z, 0,0,0, 1,1,1);}
function Mat4Scale(scale) {return matrix_build(0,0,0, 0,0,0, scale,scale,scale);}
function Mat4ScaleXYZ(xscale, yscale, zscale) {return matrix_build(0,0,0, 0,0,0, xscale,yscale,zscale);}
function Mat4TranslateScale(x, y, z, scale) {return matrix_build(x,y,z, 0,0,0, scale, scale, scale);}
function Mat4TranslateScaleXYZ(x, y, z, xscale, yscale, zscale) {return matrix_build(x,y,z, 0,0,0, xscale,yscale,zscale);}
function Mat4RotZ(zrot) {return matrix_build(0,0,0, 0,0,zrot, 1,1,1);}

function draw_sprite_billboard(sprite, subimage, xx, yy, zz, color=c_white, alpha=1) 
{
    shader_set(shd_billboard);
    matrix_set(matrix_world, matrix_build(xx, yy-zz, zz, 0, 0, 0, 1, 1, 1));
    draw_sprite_ext(sprite, subimage, 0, 0, 1, 1, 0, color, alpha);
    matrix_set(matrix_world, matrix_build_identity());
    shader_reset();
}
