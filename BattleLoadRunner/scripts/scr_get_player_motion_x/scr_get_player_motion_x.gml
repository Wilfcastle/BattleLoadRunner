/// src_get_player_motion_x - get x position as the result of horizontal movement
/// If movement would cause a collision, then adjust until you are almost touching the collider.
old_x = argument0;
old_y = argument1;
x_change = argument2;
run_speed = argument3;

var x_speed = x_change * run_speed;
var new_x = old_x;
if (scr_is_player_colliding_x(new_x + x_speed, old_y))
{
	while (scr_is_player_colliding_x(new_x + sign(x_speed), old_y) == false) 
	{
		new_x += sign(x_speed);
	}
}
else
{ 
	new_x += x_speed;
}

return new_x