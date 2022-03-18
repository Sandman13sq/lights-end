/// @desc 

switch(state)
{
	// Fadeout
	case(0):
		alpha = Approach(alpha, 1, 0.1);
		if (alpha == 1) {state++;}
		break;
	
	// Transition
	case(1):
		room_goto(targetroom);
		state++;
		break;
	
	// Fadein
	case(2):
		alpha = Approach(alpha, 0, 0.1);
		if (alpha == 0) 
		{
			instance_destroy();
		}
		break;
}