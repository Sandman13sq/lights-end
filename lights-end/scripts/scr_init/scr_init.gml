/// @desc

#macro INPUTP1 global.g_inputplayer1
#macro INPUTP2 global.g_inputplayer2

function scr_init()
{
	INPUTP1 = new InputManager();
	INPUTP2 = new InputManager();
	
	INPUTP1.DefineKey(InputIndex.right, vk_right);
	INPUTP1.DefineKey(InputIndex.up, vk_up);
	INPUTP1.DefineKey(InputIndex.left, vk_left);
	INPUTP1.DefineKey(InputIndex.down, vk_down);
	INPUTP1.DefineKey(InputIndex.fire, "X", vk_space);
	INPUTP1.DefineKey(InputIndex.focus, "Z");
	INPUTP1.DefineKey(InputIndex.flash, "C");
	INPUTP1.DefineKey(InputIndex.credit, vk_enter);
	
	INPUTP1.DefinePad(InputIndex.right, gp_padr);
	INPUTP1.DefinePad(InputIndex.up, gp_padu);
	INPUTP1.DefinePad(InputIndex.left, gp_padl);
	INPUTP1.DefinePad(InputIndex.down, gp_padd);
	INPUTP1.DefinePad(InputIndex.fire, gp_face2, gp_face3, gp_shoulderl, gp_shoulderlb);
	INPUTP1.DefinePad(InputIndex.focus, gp_face1, gp_shoulderr, gp_shoulderrb);
	INPUTP1.DefinePad(InputIndex.flash, gp_face4, gp_shoulderr, gp_shoulderrb);
	INPUTP1.DefinePad(InputIndex.credit, gp_start, gp_select);
}

scr_init();
