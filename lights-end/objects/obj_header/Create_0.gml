/// @desc

#macro CURRENT_FRAME global.g_currentframe
#macro TIMESTEP global.g_timestep

CURRENT_FRAME = 0;
TIMESTEP = 1;

hitstop = 0;
nexttimestep = 1;

draw_set_font(fnt_main);

room_goto_next();
