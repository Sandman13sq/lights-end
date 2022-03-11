/// @desc

#macro CURRENT_FRAME global.g_currentframe
#macro TIMESTEP global.g_timestep
#macro PARTSYS global.g_partsys
#macro DEBUG global.g_debug

CURRENT_FRAME = 0;
TIMESTEP = 1;
DEBUG = 1;

hitstop = 0;
nexttimestep = 1;

debugoverlay = true;
show_debug_overlay(debugoverlay);

draw_set_font(fnt_main);

PARTSYS = part_system_create();
part_system_depth(PARTSYS, -1000);

enum ST_Camera
{
	free = 0,
	player,
	followX,
	followY,
	focus,
	
	followRight,
	followUp,
	followLeft,
	followDown,
}

cameraposition = [0, 0, 0];
cameralookfrom = [0, -500, 1000];
camerafocus = [0, 0, 0];
camerastate = ST_Camera.player;

matproj = matrix_build_identity();
matview = matrix_build_identity();
matbillboard = matrix_build_identity();

roommats = [
	matrix_get(matrix_projection),
	matrix_get(matrix_view),
	matrix_get(matrix_world)
];

shd_3d_campos = shader_get_uniform(shd_3d, "u_campos");

firstcamerasync = true;
playerboundsdimensions = [600, 300];

screenshake = 0;

room_goto_next();

