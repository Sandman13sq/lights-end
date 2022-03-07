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

