/// @desc Camera State

var ts = TIMESTEP;
var camspeed = ts*10;

switch(camerastate)
{
	case(ST_Camera.free):
		
		break;
	
	case(ST_Camera.player):
		camerapos[0] = Approach(camerapos[0], obj_player.x, camspeed);
		camerapos[1] = Approach(camerapos[1], obj_player.y, camspeed);
		break;
	
	case(ST_Camera.followX):
		camerapos[0] = Approach(camerapos[0], obj_player.x, camspeed);
		camerapos[1] = Approach(camerapos[1], camerafocus[1], camspeed);
		break;
	
	case(ST_Camera.followY):
		camerapos[0] = Approach(camerapos[0], camerafocus[0], camspeed);
		camerapos[1] = Approach(camerapos[1], obj_player.y, camspeed);
		break;
	
	case(ST_Camera.focus):
		camerapos[0] = Approach(camerapos[0], camerafocus[0], camspeed);
		camerapos[1] = Approach(camerapos[1], camerafocus[1], camspeed);
		break;
}

