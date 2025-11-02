function player_jump(){
	
	var currently_jumping = false
	var jump_keys = [vk_space, vk_up, ord("W")]
	
	// see if the jump button is currently being held down.
	for (var i = 0; i < array_length(jump_keys); i++) {
		if keyboard_check(jump_keys[i]) currently_jumping = true;
	}
	
	// if we're not currently jumping, we don't care
	if (!currently_jumping) return;
	
	// power of initial leap
	var jump_force = -8;
	
	// keep floating up a bit after jumping when up is held
	var float_force = -0.000008;
	
	// if we are on the ground
	if (place_meeting(x, y+3, oTile)) {
		global.y_vel = jump_force;
	}
	
	// if we are not on the ground
	else {
		//global.y_vel += float_force * delta_time;
	}
}