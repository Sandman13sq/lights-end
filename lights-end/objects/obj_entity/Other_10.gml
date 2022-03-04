/// @desc Methods & Functions

function Update(ts=1)
{
		
}

function Draw()
{
	if (sprite_exists(sprite_index))
	{
		draw_sprite_ext(
			sprite_index, image_index,
			x, y,
			image_xscale, image_yscale,
			0, c_white, 1
		);	
	}
}

function SetState(_state)
{
	state = _state;
	statestart = 1;
}

