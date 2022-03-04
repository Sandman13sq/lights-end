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
	return (x mod step*2) < step;
}
