/*
*/

#macro PARTTYPE global.g_parttype

enum PType
{
	onyxdebris
}

function PartParticlesCircle(psys, pt, x, y, rw, rh, color, n)
{
	var d;
	repeat(n)
	{
		d = random(360);
		part_particles_create_color(
			psys, 
			x + lengthdir_x(rw*random(1), d), 
			y + lengthdir_y(rh*random(1), d), 
			pt, color, 1
			);
	}
	
}

var pt = part_type_create();
PARTTYPE[PType.onyxdebris] = pt;
part_type_gravity(pt, 0.1, 90);
part_type_direction(pt, 70, 110, 0, 0);
part_type_sprite(pt, spr_pixel, 0, 0, 0);
part_type_speed(pt, 1, 4, 0, 0.2);
part_type_size(pt, 10, 20, -0.1, 0);

function GFX_BloodSpray(xx, yy, zz, facingright)
{
	with instance_create_depth(xx, yy, 0, obj_bloodspray)
	{
		z = zz;
		image_xscale = Polarize(facingright);
	}
}

function GFX_Onyxplode(xx, yy, zz)
{
	with instance_create_depth(xx, yy, 0, obj_onyxplode)
	{
		z = zz;
	}
}
