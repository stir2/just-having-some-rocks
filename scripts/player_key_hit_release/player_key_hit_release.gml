// go ahead and make these so other people can use them :)
global.moving_left = false;
global.moving_right = false;
global.y_vel = 0;
global.y_acc = 0.5;
global.stage_finished = false;

function player_key_hit_release() {
	
	// arrays of keys that equal left/right
	var left_keys = [vk_left, ord("A")]
	var right_keys = [vk_right, ord("D")]
	
	// the directoin to move
	global.moving_left = false;
	global.moving_right = false;

	// test if any left keys are hit
	var test_left_key = function(key_to_test) {
		if (keyboard_check(key_to_test)) global.moving_left = true;
	}

	// test if any right keys are hit
	var test_right_key = function(key_to_test) {
		if (keyboard_check(key_to_test)) global.moving_right = true;
	}
	
	// update the global variables `global.moving_right` and `global.moving_left` so that they are up to date.	
	array_foreach(left_keys, test_left_key)
	array_foreach(right_keys, test_right_key)
	
	// if both left and right are held or neither are held, return
	if (global.moving_left == global.moving_right) {
		// set the player animation to idle since he's no longer moving
		sprite_index = sPlayerIdle;
	
		// set the "moving left" and "moving right" variables to false in case anyone else wants to use them
		global.moving_left = false;
		global.moving_right = false;
		return;
	}

	// direction: +1 for right -1 for left
	var direc = global.moving_right ? 1 : -1;

	// flip the image in the right direction and play the walking animation
	image_xscale = direc;
	sprite_index = sPlayerWalk;
}