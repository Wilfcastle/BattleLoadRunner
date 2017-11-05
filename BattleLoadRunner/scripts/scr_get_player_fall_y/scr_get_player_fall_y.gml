/// scr_get_player_fall_y - Get y coordinate while falling.

// If we our falling would make us collide with a solid object, 
// then reduce speed until we are almost touching.
old_x = argument0;
old_y = argument1;
fall_speed = argument2;

var new_y = old_y;
if (scr_is_player_colliding_y(old_x, new_y + fall_speed + 1))
{
	while (scr_is_player_colliding_y(old_x, new_y + global.object_fall_collision_distance) == false) 
	{
	    new_y += 1;
	}
}
else
{ 
	new_y += fall_speed;
}
	
show_debug_message("Falling. Old Y " + string(old_y) + " New Y " + string(new_y));
return new_y;