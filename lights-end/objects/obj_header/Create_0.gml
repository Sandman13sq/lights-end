/// @desc

#macro CURRENT_FRAME global.g_currentframe
#macro TIMESTEP global.g_timestep

CURRENT_FRAME = 0;
TIMESTEP = 1;

hitstop = 0;
nexttimestep = 1;

debugoverlay = true;
show_debug_overlay(debugoverlay);

draw_set_font(fnt_main);

#macro PARTSYS global.g_partsys
PARTSYS = part_system_create();
part_system_depth(PARTSYS, -1000);

camerapos = [0, 0, 0];
//cameralookfrom = [0, -22, 21.7];
cameralookfrom = [0, -500, 1000];
//cameralookfrom = [0, 22, 21.7];

matproj = matrix_build_identity();
matview = matrix_build_identity();
matbillboard = matrix_build_identity();

roommats = [
	matrix_get(matrix_projection),
	matrix_get(matrix_view),
	matrix_get(matrix_world)
];

shd_3d_uvbounds = shader_get_uniform(shd_3d, "u_uvbounds");

room_goto_next();

