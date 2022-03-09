/// @desc Player Bounds


playerbounds = [
	DefineLine(0, 0, 0, 0),
	DefineLine(0, 0, 0, 0),
	DefineLine(0, 0, 0, 0),
	DefineLine(0, 0, 0, 0),
];

playerbounds[0].collisionfilter &= ~FL_Collision.enemy;
playerbounds[1].collisionfilter &= ~FL_Collision.enemy;
playerbounds[2].collisionfilter &= ~FL_Collision.enemy;
playerbounds[3].collisionfilter &= ~FL_Collision.enemy;

firstcamerasync = false;
