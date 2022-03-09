/// @desc

function Approach(value, target, step)
{
	if (value < target) {return min(target, value+step);}
	return max(target, value-step);
}

function Lev(positive, negative)
{
	return bool(positive) - bool(negative);
}

function LevKeyPressed(keypositive, keynegative)
	{return keyboard_check_pressed(keypositive)-keyboard_check_pressed(keynegative);}
function LevKeyHeld(keypositive, keynegative)
	{return keyboard_check(keypositive)-keyboard_check(keynegative);}
function LevKeyReleased(keypositive, keynegative)
	{return keyboard_check_released(keypositive)-keyboard_check_released(keynegative);}

function Polarize(value)
{
	return value? 1: -1;
}

function Modulo(x, y)
{
	while (x > y) {x -= y;}
	while (x < 0) {x += y;}
	return x;
}

function BoolStep(x, step)
{
	return (x mod step*2) > step;
}

/// @desc Returns true if intersection is present
/// [x, y, distance] on success, [undefined] x 3 on fail
function CircleOnLine(px, py, radius, Ax, Ay, Bx, By, outvec2)
{
	/*
		SAUCE: http://www.jeffreythompson.org/collision-detection/line-circle.php
	*/

	// Calculate closest point to circle center
	var _dist = point_distance(Ax, Ay, Bx, By),
		_dot = ( (px - Ax) * (Bx - Ax) + (py - Ay) * (By - Ay) ) / (_dist * _dist),
		_closestX = Ax + (_dot * (Bx - Ax) ),
		_closestY = Ay + (_dot * (By - Ay) );

	// Line - Point
	var _d1 = point_distance(_closestX, _closestY, Ax, Ay),
		_d2 = point_distance(_closestX, _closestY, Bx, By),
		_sum = _d1 + _d2;

	// Test if point rests on line segment
	if !(_sum >= (_dist - 0.01) && _sum <= (_dist + 0.01) )
	{
		return false;
	}

	// Test distance to point against radius
	if point_distance(_closestX, _closestY, px, py) <= radius
	{
		outvec2[@ 0] = _closestX;
		outvec2[@ 1] = _closestY;
		//outvec2[@ 2] = _dist;
		return true;
	}
	
	return false;
}

function CircleOnCircle(x1, y1, r1, x2, y2, r2)
{
	return point_distance(x1, y1, x2, y2) < r1+r2;
}


function DotAngle(angle1, angle2)
{
	return dot_product(dcos(angle1), dsin(angle1), dcos(angle2), dsin(angle2));
}

