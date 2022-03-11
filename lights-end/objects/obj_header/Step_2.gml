/// @desc Camera State

var ts = TIMESTEP;
var camspeed = ts*10;

switch(camerastate)
{
	case(ST_Camera.free):
		
		break;
	
	case(ST_Camera.player):
		cameraposition[0] = Approach(cameraposition[0], obj_player.x, camspeed);
		cameraposition[1] = Approach(cameraposition[1], obj_player.y, camspeed);
		break;
	
	case(ST_Camera.followX):
		cameraposition[0] = Approach(cameraposition[0], obj_player.x, camspeed);
		cameraposition[1] = Approach(cameraposition[1], camerafocus[1], camspeed);
		break;
	
	case(ST_Camera.followY):
		cameraposition[0] = Approach(cameraposition[0], camerafocus[0], camspeed);
		cameraposition[1] = Approach(cameraposition[1], obj_player.y, camspeed);
		break;
	
	case(ST_Camera.focus):
		cameraposition[0] = Approach(cameraposition[0], camerafocus[0], camspeed);
		cameraposition[1] = Approach(cameraposition[1], camerafocus[1], camspeed);
		break;
	
	case(ST_Camera.followRight):
		cameraposition[0] = max(cameraposition[0], Approach(cameraposition[0], obj_player.x, camspeed));
		cameraposition[1] = Approach(cameraposition[1], camerafocus[1], camspeed);
		break;
	
	case(ST_Camera.followUp):
		cameraposition[0] = Approach(cameraposition[0], camerafocus[0], camspeed);
		cameraposition[1] = min(cameraposition[1], Approach(cameraposition[1], obj_player.y, camspeed));
		break;
	
	case(ST_Camera.followLeft):
		cameraposition[0] = min(cameraposition[0], Approach(cameraposition[0], obj_player.x, camspeed));
		cameraposition[1] = Approach(cameraposition[1], camerafocus[1], camspeed);
		break;
	
	case(ST_Camera.followDown):
		cameraposition[0] = Approach(cameraposition[0], camerafocus[0], camspeed);
		cameraposition[1] = max(cameraposition[1], Approach(cameraposition[1], obj_player.y, camspeed));
		break;
}

if (!firstcamerasync)
{
	firstcamerasync = true;
	cameraposition[0] = camerafocus[0];
	cameraposition[1] = camerafocus[1];
	cameraposition[2] = camerafocus[2];
}
