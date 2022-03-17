/// @desc

function Approach(value, target, step)
{
	if (value < target) {return min(target, value+step);}
	return max(target, value-step);
}

function ApproachZero(value, step)
{
	return (value < 0)? min(0, value+step): max(0, value-step);
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

function Wrap(value, x1, x2)
{
	var d = x2-x1;
	while (value < x1) {value += d;}
	while (value >= x2) {value -= d;}
	return value;
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

// Reflects angle using normal
function NormalReflect(incomingAngle, normalAngle)
{
	var _n0 = dcos(normalAngle), _n1 = -dsin(normalAngle),
		_d0 = dcos(incomingAngle), _d1 = -dsin(incomingAngle),
		_2dot = 2 * dot_product(_n0, _n1, _d0, _d1);
		
	return darctan2(
		_d1 - _2dot * _n1, 
		_d0 - _2dot * _n0);
		
	var _angle = angle_difference(normalAngle, incomingAngle);
	if _angle == 0 {return normalAngle + 180;}
	var _incidence = (180 - abs(_angle)) * -sign(_angle);
		
	return (normalAngle + _incidence);
}

function FlipDirection(angle)
{
	return point_direction(0,0,
		lengthdir_x(-1, angle),
		lengthdir_y(-1, angle)
		)	
}

function FlipDirectionX(angle)
{
	return point_direction(0,0,
		lengthdir_x(-1, angle),
		lengthdir_y(1, angle)
		)	
}

function Quantize(x, step) {return floor(x/step)*step;}
function QuantizeCeil(x, step) {return ceil(x/step)*step;}
function QuantizeRound(x, step) {return round(x/step)*step;}

