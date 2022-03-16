/// @desc 

// Inherit the parent event
event_inherited();

visible = true;

function Update(ts)
{
	image_index = Modulo(image_index + ts/3, 2);
	
	x += lengthdir_x(movespeed, movedirection)*ts;
	y += lengthdir_y(movespeed, movedirection)*ts;
	
	if (EvaluateLineCollision())
	{
		OnDefeat();
		return;
	}
}

function OnDamage(damage, angle, knockback)
{
	ShowScore(x, y, 10, false);
}

function OnDefeat()
{
	instance_destroy();
}

function SetDirection(dir)
{
	movedirection = dir;
}
