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

room_goto_next();

