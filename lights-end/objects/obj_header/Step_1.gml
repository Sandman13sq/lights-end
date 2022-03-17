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
camerafocus[0] += 10*LevKeyHeld(ord("D"), ord("A"));
cameraposition[0] += 10*LevKeyHeld(ord("D"), ord("A"));
camerafocus[1] -= 10*LevKeyHeld(ord("W"), ord("S"));
cameraposition[1] -= 10*LevKeyHeld(ord("W"), ord("S"));

var cx = cameraposition[0], cy = cameraposition[1];
var ww = playerboundsdimensions[0], hh = playerboundsdimensions[1];
playerbounds[0].SetLine(cx-ww, cy-hh, cx+ww, cy-hh);
playerbounds[1].SetLine(cx+ww, cy-hh, cx+ww, cy+hh);
playerbounds[2].SetLine(cx+ww, cy+hh, cx-ww, cy+hh);
playerbounds[3].SetLine(cx-ww, cy+hh, cx-ww, cy-hh);

screenshake = Approach(screenshake, 0, nexttimestep);

if (SCREEN_W != lastscreensize[0] || SCREEN_H != lastscreensize[1])
{
	lastscreensize[0] = SCREEN_W;
	lastscreensize[1] = SCREEN_H;
	surface_resize(application_surface, SCREEN_W, SCREEN_H);	
}

// Input
if ( !INPUTP1.HasDevice() ) {INPUTP1.PollDevice();}
else if ( !INPUTP2.HasDevice() ) {INPUTP2.PollDevice();}

INPUTP1.Update();
INPUTP2.Update();
