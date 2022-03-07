/*
*/

#macro ORANDOMMAX 255

// Returns pseudo random number between 0 and 255
function ORandom()
{
	var r = irandom(ORANDOMMAX+1);
	return r;
}
