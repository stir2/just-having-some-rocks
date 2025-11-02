// an array of all objects that the player can collide with.
var things_that_are_collidable = [oTile]

if (global.stage_finished) {return}

///////////
// MOVING X
///////////

// if we're walking in a direction
if (global.moving_right || global.moving_left) {

	// set the player walkspeed
	var player_speed = 0.0003;
	var direc = global.moving_right? 1 : (-1);

	// calculate size of step in x direc
	var step_size_x = player_speed * direc * delta_time;

	// make sure the space is empty and move x
	if (!place_meeting(x + step_size_x, y-1, things_that_are_collidable)) {
		// actually move
		x += step_size_x
	}
}

///////////
// MOVING Y
///////////

// calculate the size of step in y direc
var step_size_y = global.y_vel;

// if there is nothing stopping the player's fall
if (!place_meeting(x, y + step_size_y, things_that_are_collidable)) {
	// move and change velocity by acceleratoin
	y += step_size_y;
	global.y_vel += global.y_acc;
} 

else {
	// if we would hit something, step down until we actually hit it.
	var full_step_y = 0;
	while (true) {
		if (!place_meeting(x, y + full_step_y, things_that_are_collidable)) full_step_y += 1;
		else break;
	}
	
	y += full_step_y;
}