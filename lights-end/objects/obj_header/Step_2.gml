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
	
	case(ST_Camera.followRight):
		camerapos[0] = max(camerapos[0], Approach(camerapos[0], obj_player.x, camspeed));
		camerapos[1] = Approach(camerapos[1], camerafocus[1], camspeed);
		break;
	
	case(ST_Camera.followUp):
		camerapos[0] = Approach(camerapos[0], camerafocus[0], camspeed);
		camerapos[1] = min(camerapos[1], Approach(camerapos[1], obj_player.y, camspeed));
		break;
	
	case(ST_Camera.followLeft):
		camerapos[0] = min(camerapos[0], Approach(camerapos[0], obj_player.x, camspeed));
		camerapos[1] = Approach(camerapos[1], camerafocus[1], camspeed);
		break;
	
	case(ST_Camera.followDown):
		camerapos[0] = Approach(camerapos[0], camerafocus[0], camspeed);
		camerapos[1] = max(camerapos[1], Approach(camerapos[1], obj_player.y, camspeed));
		break;
}

if (!firstcamerasync)
{
	firstcamerasync = true;
	camerapos[0] = camerafocus[0];
	camerapos[1] = camerafocus[1];
	camerapos[2] = camerafocus[2];
}
