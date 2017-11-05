/// scr_get_player_climb_y - Get y coordinate while climbing.

// Can't run into blocks while climbing. 
// Can only climb to one pixel higher than the ladder.
old_x = argument0;
old_y = argument1;
y_change = argument2;
climb_speed = argument3;

var y_speed = y_change * climb_speed;
var new_y = old_y;
if ((place_meeting(old_x, new_y + y_speed, obj_dblock)) || 
	(place_meeting(old_x, new_y + y_speed + 1, obj_ladder) == false))
{
	while ((place_meeting(old_x, new_y + sign(y_speed), obj_dblock) == false) &&
  	       (place_meeting(old_x, new_y + sign(y_speed), obj_ladder)))
			{
				new_y += sign(y_speed);
			}
}
else
{ 
	new_y += y_speed;
}

show_debug_message("Climbing. Old Y " + string(old_y) + " New Y " + string(new_y));
return new_y;