///scr_check_player_collision with collidable objects
proposed_x_loc = argument0;
proposed_y_loc = argument1;

if (place_meeting(proposed_x_loc, proposed_y_loc, obj_dblock))
{
	return true;
}

if (place_meeting(proposed_x_loc, proposed_y_loc, obj_block))
{
	return true;
}

// Don't forget to do other players or monsters too!
return false;