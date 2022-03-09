/// @desc Methods & Functions

function SetHealthMax(value)
{
	healthmax = value;
	healthpoints = healthmax;
}

function Update(ts=1)
{
	
}

function Draw()
{
	if (sprite_exists(sprite_index))
	{
		var xy = WorldToScreenXY(x, y, z), xx = xy[0], yy = xy[1];
		
		if (xshake > 0)
		{
			xx += 3 * Polarize(BoolStep(xshake, 4));
		}
		
		draw_sprite_ext(
			sprite_index, image_index,
			xx, yy,
			image_xscale, image_yscale,
			0, c_white, 1
		);	
	}
}

function Draw3D()
{
	draw_sprite_billboard(spr_shadow, 0, x, y, 0, LightsEndColor.dark);
	draw_sprite_billboard(sprite_index, image_index, x, y, z);
	
	return;
	
	matrix_set(matrix_world, Mat4Sprite(sprite_index, image_index, x, y, z));
	
	U_SetUVBounds(UVSSPRITE[sprite_index][image_index]);
	//matrix_set(matrix_world, obj_header.matbillboard);
	vertex_submit(vb_sprite, pr_trianglelist, sprite_get_texture(sprite_index, image_index));
	
	U_SetUVBounds();
	matrix_set(matrix_world, 
		matrix_multiply(
			obj_header.matbillboard,	// Transform panel to sprite size
			matrix_build(x*DRAWSCALE3D, y*DRAWSCALE3D, z*DRAWSCALE3D, 0, 0, 0, 1, 1, 1),	// Move model
			)
		);
	vertex_submit(vb_axis, pr_trianglelist, -1);
}

function SetState(_state)
{
	state = _state;
	statestart = 1;
}

function PopStateStart()
{
	if (statestart) {statestart = 0; return true;}
	return false;
}

function DrawShadow()
{
	var xy = WorldToScreenXY(x, y, 0), xx = xy[0], yy = xy[1];
	draw_sprite_ext(spr_shadow, 0, xx, yy, 1, 1, 0, LightsEndColor.dark, 1);
}

// Decrements health from entity
function DoDamage(value)
{
	healthpoints = max(0, healthpoints-value);
	OnDamage(value);
	
	if (healthpoints == 0)
	{
		OnDefeat();
	}
}

function OnDamage(damage)
{
	if (damage > 0)
	{
		xshake = XSHAKETIME;
	}
}

// Called when health is zero
function OnDefeat()
{
	instance_destroy();
}

function SetFlag(f) {entityflag |= f;}
function ClearFlag(f) {entityflag &= ~(f);}
function HasFlag(f) {return (entityflag & f) != 0;}

function GetHealth() {return healthpoints;}
function GetDamage() {return damage;}

function EvaluateLineCollision()
{
	// Check lines
	ds_list_clear(hitlist);
	var intersect = [0, 0], dir;
	var n = collision_circle_list(x, y, 128, obj_lvl_line, false, true, hitlist, false);
	var e;
	
	for (var i = 0; i < n; i++)
	{
		e = hitlist[| i];
		
		// Line
		if ( CircleOnLine(x, y, radius, e.x1, e.y1, e.x2, e.y2, intersect)	)
		{
			if (DotAngle(point_direction(intersect[0], intersect[1], x, y), e.normal) < 0)
			{
				x = intersect[0] + lengthdir_x(radius+1, e.normal+180);
				y = intersect[1] + lengthdir_y(radius+1, e.normal+180);
			}
			else
			{
				x = intersect[0] + lengthdir_x(radius+1, e.normal);
				y = intersect[1] + lengthdir_y(radius+1, e.normal);
			}
		}
		
		// Endpoints
		if ( point_distance(e.x1, e.y1, x, y) <= radius )
		{
			dir = point_direction(e.x1, e.y1, x, y);
			x = e.x1 + lengthdir_x(radius+1, dir);
			y = e.y1 + lengthdir_y(radius+1, dir);
		}
		
		if ( point_distance(e.x2, e.y2, x, y) <= radius )
		{
			dir = point_direction(e.x2, e.y2, x, y);
			x = e.x2 + lengthdir_x(radius+1, dir);
			y = e.y2 + lengthdir_y(radius+1, dir);
		}
	}
	
}