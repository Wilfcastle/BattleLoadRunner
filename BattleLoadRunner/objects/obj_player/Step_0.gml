/// @description Control Player in Step

scr_globals();

enum sprite_state
{
walkleft,
walkright,
digleft,
digright,
climbing,
shimming,
idle,
dying,
falling,
}

enum player_state
{
evaluate,
digging,
climbing,
shimming,
dying,
falling,
}


// In abscense of any state change, we dance.
var player_sprite_state = sprite_state.idle;

scr_get_input();

var x_change = (right_key - left_key);
var y_change = (down_key - up_key);

starting_x = x;
starting_y = y;

// Detect if we need to fall. Falling takes precident over all other movement.
//    - Do not fall if we are on solid ground.
//    - Do not fall if we are climbing.
//    - Do not fall if we are standing on a ladder.
//    - Do not fall if we are shimming.
//    Note - we only fall if we are not directly standing on something.
if ((scr_is_player_colliding_y(x, y + global.object_fall_collision_distance) == false) && 
    (object_state != player_state.climbing))
{
    y = scr_get_player_fall_y(x, y, fall_speed);
	player_sprite_state = sprite_state.falling;
	object_state = player_state.falling;
}
// Because we are not falling, we have a much wider range of movement options.
else
{
	// Horizontal movement takes effect if you are walking, climbing, or shimming.
	// (So it takes effect in almost every state.)
	if (x_change != 0) 
	{
		x = scr_get_player_motion_x(x,y, x_change, run_speed);
		
		// Determine if we should display moving left or right depending on applied motion.
		player_sprite_state = (x_change > 0) ? sprite_state.walkright : sprite_state.walkleft;
	}

	// Detect when to start or continue climbing.
	//    - Consider climbing when moving down while in or standing on a ladder.
	//    - Consider climbing up when in a ladder.
	//    - Note that a negative y change means moving up and vice-versa. This is confusing.
	if (((y_change > 0) && 
	     ((place_meeting(x, y, obj_ladder)) || 
		  (place_meeting(x, y + 1, obj_ladder))))
		 ||
	    ((y_change < 0) && 
		 ((place_meeting(x, y, obj_ladder)))))
	{
		y = scr_get_player_climb_y(x, y, y_change, climb_speed);
		player_sprite_state = sprite_state.climbing;
		object_state = player_state.climbing;
	}
	// Keep climbing.
	else if ((object_state == player_state.climbing) && (place_meeting(x, y, obj_ladder)))
	{
		object_state = player_state.climbing;
		player_sprite_state = sprite_state.climbing;
	}
	// Reevaluate our position if we have climbed off of the ladder.
	else if ((object_state == player_state.climbing) && (place_meeting(x, y, obj_ladder) == false))
	{
		show_debug_message("Climbed off ladder");
		object_state = player_state.evaluate;
	}
    
    // TODO handle shimming
}


// Transition sprite based on proposed sprite_state.
switch (player_sprite_state)
{
	case sprite_state.walkleft:
		sprite_index = spr_player1_walkleft;
		image_speed = .5;
		//image_index = (x/ running_frame_delay) mod image_number;
		break;
		
	case sprite_state.walkright:
		sprite_index = spr_player1_walkright;
		image_speed = .5;
		//image_index = (x/ running_frame_delay) mod image_number;
		break;
		
	case sprite_state.digleft:
		image_speed = .5;
		sprite_index = spr_player1_digleft;
		break;

	case sprite_state.digright:
		image_speed = .5;
		sprite_index = spr_player1_digright;
		break;
				
	case sprite_state.climbing:
		sprite_index = spr_player1_climb;
		if (y_change != 0 || x_change != 0) image_speed = 1.5;
		else image_speed = 0;
		break;
		
	case sprite_state.shimming:
		break;
		
	case sprite_state.idle:
		sprite_index = spr_player1_idle;
		//image_index = (idle_frame / idle_frame_delay) mod (image_number );
		image_speed = .8;
		break;
		
	case sprite_state.dying:
		break;

	case sprite_state.falling:
		sprite_index = spr_player1_falling;
		break;
}

//show_debug_message("Step over Starting Y " + string(starting_y) + " New Y " + string(y));