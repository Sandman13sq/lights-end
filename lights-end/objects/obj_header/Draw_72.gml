/// @desc 

draw_clear_alpha(0, 0);

// Store state
gpu_push_state();
	
roommats = [
	matrix_get(matrix_projection),
	matrix_get(matrix_view),
	matrix_get(matrix_world)
];

// Setup Drawing
ShaderSet(shd_3d);

gpu_set_ztestenable(true);
gpu_set_zwriteenable(true);
//gpu_set_alphatestenable(true);

// Set up matrices
matproj = matrix_build_projection_perspective_fov(
	40, window_get_width()/window_get_height(), 10, 20000);
matview = matrix_build_lookat(
	cameraposition[0] + cameralookfrom[0],
	cameraposition[1] - cameralookfrom[1],
	cameraposition[2] + cameralookfrom[2],
	cameraposition[0],
	cameraposition[1],
	cameraposition[2],
	0, 0, 1
	);

// Screen shake using up vector
var yshake = 2 * sqrt(screenshake) * sin(screenshake);
matview = matrix_multiply(
	Mat4Translate(yshake*matview[1], yshake*matview[5], yshake*matview[9]), matview);

matbillboard = [
	matview[ 0], matview[ 4], matview[ 8], 0,
	-matview[ 1], -matview[ 5], -matview[ 9], 0,
	matview[ 2], matview[ 6], matview[10], 0,
	0, 0, 0, 1
];

// Flip y-coordinate if on OperaGX
if (os_type == os_operagx)
{
	matproj = matrix_multiply(Mat4ScaleXYZ(1,-1,1), matproj);
}

// Without these, objects wouldn't be drawn outside a limited range
camera_set_view_pos(view_camera, cameraposition[0], cameraposition[1]);
camera_set_proj_mat(view_camera, matproj);

matrix_set(matrix_projection, matproj);
matrix_set(matrix_view, matview);
matrix_set(matrix_world, matrix_build_identity());

shader_set_uniform_f_array(shd_3d_campos, cameraposition);

// Draw all world vbs
gpu_set_cullmode(cull_clockwise);
with obj_worldvb
{
	if (visible)
	{
		Draw();
	}
}

// Draw Entities
with obj_entity
{
	if (visible && active)
	{
		Draw3D();
	}
}

// Draw Billboards
gpu_set_cullmode(cull_noculling);
ShaderSet(shd_default);
with obj_entity
{
	if (visible && active)
	{
		Draw();
	}
}

if (DEBUG >= 1)
{
	ShaderSet(shd_default);
	gpu_set_ztestenable(false); //  Draw All
	matrix_set(matrix_world, Mat4());
	
	// Draw entity radii
	var angle = 0;
	draw_primitive_begin(pr_linelist);
	with obj_entity
	{
		repeat(12)
		{
			draw_vertex_color(
				x + lengthdir_x(radius, angle), 
				y + lengthdir_y(radius, angle), 
				c_orange, 1);
		
			angle += 360/12;
			draw_vertex_color(
				x + lengthdir_x(radius, angle), 
				y + lengthdir_y(radius, angle), 
				c_orange, 1);
		}
	}
	//draw_primitive_end();
	
	// Draw collision lines
	//draw_primitive_begin(pr_linelist);
	var c;
	with obj_lvl_line
	{
		if (active) {c = (collisionfilter & FL_Collision.enemy)? c_lime: c_yellow;}
		else {c = c_green;}
		draw_vertex_color(x1, y1, c, 1);
		draw_vertex_color(x2, y2, c, 1);
	}
	//draw_primitive_end();
	
	// Draw triggers
	//draw_primitive_begin(pr_linelist);
	with obj_lvl_trigger
	{
		draw_vertex_color(bbox_left, bbox_top, c_fuchsia, 1);
		draw_vertex_color(bbox_right, bbox_top, c_fuchsia, 1);
		draw_vertex_color(bbox_right, bbox_bottom, c_fuchsia, 1);
		draw_vertex_color(bbox_left, bbox_bottom, c_fuchsia, 1);
	}
	draw_primitive_end();

	gpu_set_ztestenable(true);
}

