/// @desc

// Inherit the parent event
event_inherited();

life = 400;

circcount = 16;
circs = array_create(circcount);
for (var i = 0; i < circcount; i++)
{
	circ[i] = [
		random_range(-30, 30),	// x
		random_range(-30, 30),	// y
		random_range(0, 12),	// z
		random_range(40, 60),	// Size
		
		random_range(-10, 10),	// xspeed
		random_range(1, 2),	// zspeed
		merge_color(0, c_purple, random(1)),	// color
		];
}

