/// @desc

// Inherit the parent event
event_inherited();

function Darken()
{
	
}

function PushOtherEnemies()
{
	var e;
	var n = EvaluateRadius(radius, obj_enemy);
	for (var i = 0; i < n; i++)
	{
		e = hitlist[| i];
		
		if ( e.HasFlag(FL_Entity.shootable) && e.GetHealth() > 0 )
		{
			var d = DirectionTo(e);
			
			x -= lengthdir_x(1, d);
			y -= lengthdir_y(1, d);
			e.x += lengthdir_x(1, d);
			e.y += lengthdir_y(1, d);
		}
	}
}

function Flashed(px, py)
{
	OnFlash(px, py);
}

function OnFlash(px, py)
{
	
}
