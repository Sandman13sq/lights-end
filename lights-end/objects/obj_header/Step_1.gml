/// @desc

// Toggle Debug Overlay
if (keyboard_check_pressed(ord("0")))
{
	debugoverlay ^= 1;
	show_debug_overlay(debugoverlay);
}

if (keyboard_check_pressed(ord("9")))
{
	DEBUG ^= 1;
}

// Toggle Fullscreen
if (keyboard_check_pressed(vk_f4))
{
	window_set_fullscreen(!window_get_fullscreen());
}

if (keyboard_check_pressed(vk_escape))
{
	window_set_fullscreen(false);
}

// Restart
if (keyboard_check(vk_tab))
{
	if (keyboard_check_pressed(ord("R")))
	{
		game_restart();
		return;
	}
}

// Progress hitstop
if (hitstop > 0)
{
	hitstop = Approach(hitstop, 0, 1);
	TIMESTEP = 0;
}
else
{
	TIMESTEP = nexttimestep;
}

CURRENT_FRAME++;

// Camera
camerapos[0] += LevKeyHeld(ord("D"), ord("A"));
camerapos[1] += LevKeyHeld(ord("W"), ord("S"));

