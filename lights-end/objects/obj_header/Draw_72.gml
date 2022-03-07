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
shader_set(shd_3d);

gpu_set_cullmode(cull_clockwise);
gpu_set_ztestenable(true);
gpu_set_zwriteenable(true);
//gpu_set_alphatestenable(true);

if (instance_exists(obj_player))
{
	camerapos[0] = obj_player.x;	
	camerapos[1] = obj_player.y;	
}

matproj = matrix_build_projection_perspective_fov(40, window_get_width()/window_get_height(), 10, 20000);
matview = matrix_build_lookat(
	camerapos[0] + cameralookfrom[0],
	camerapos[1] - cameralookfrom[1],
	camerapos[2] + cameralookfrom[2],
	camerapos[0],
	camerapos[1],
	camerapos[2],
	0, 0, 1
	);

matbillboard = [
	matview[ 0], matview[ 4], matview[ 8], 0,
	-matview[ 1], -matview[ 5], -matview[ 9], 0,
	matview[ 2], matview[ 6], matview[10], 0,
	0, 0, 0, 1
];

// Without these, objects wouldn't be drawn outside a limited range
camera_set_view_pos(view_camera, camerapos[0], camerapos[1]);
camera_set_proj_mat(view_camera, matproj);

matrix_set(matrix_projection, matproj);
matrix_set(matrix_view, matview);
matrix_set(matrix_world, matrix_build_identity());

// Draw all world vbs
with obj_worldvb
{
	if (visible)
	{
		Draw();
	}
}

gpu_set_cullmode(cull_noculling);
with obj_entity
{
	if (visible)
	{
		Draw3D();
	}
}

