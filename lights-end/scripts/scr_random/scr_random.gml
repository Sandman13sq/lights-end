/*
*/

#macro ORANDOMMAX 255

// Returns pseudo random number between 0 and 255
function ORandom(x=256)
{
	var r = irandom(ORANDOMMAX+1);
	return r % x;
}

function ORandomRange(x1, x2)
{
	return ORandom(x2-x1)+x1;
}