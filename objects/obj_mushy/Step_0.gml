var input_right = keyboard_check(vk_right) || keyboard_check(ord("D"));
var input_left = keyboard_check(vk_left) || keyboard_check(ord("A"));
var input_up = keyboard_check(vk_up) || keyboard_check(ord("W"));
var input_down = keyboard_check(vk_down) || keyboard_check(ord("X"));

var right_pressed = (keyboard_check_pressed(vk_right) || keyboard_check_pressed(ord("D")));
var left_pressed = (keyboard_check_pressed(vk_left) || keyboard_check_pressed(ord("A")));
var up_pressed = (keyboard_check_pressed(vk_up) || keyboard_check_pressed(ord("W")));
var down_pressed = (keyboard_check_pressed(vk_down) || keyboard_check_pressed(ord("X")));
var dive_pressed = (keyboard_check_pressed(ord("C")));

if(up_pressed)
latest_input_up_t = global.t;

if(down_pressed)
latest_input_down_t = global.t;

if(dive_pressed && !diving)
latest_input_dive_t = global.t;

if(global.freezeframe <= 0){
	if(input_right && (latest_input_x != -1)){
		input_x = 1;
	} else if(input_left && (latest_input_x != 1)){
		input_x = -1;
	} else {
		input_x = input_right - input_left;
	}
	
	if(diving && global.t - latest_input_dive_t == dive_freezeframe){
		vel_x += latest_input_x * vel_dive_x;
		dive_dir = latest_input_x;
		vel_y += vel_dive_y;
	}

	input_y = keyboard_check(vk_up) - keyboard_check(vk_down);

	vel_x += input_x * accel_x;
	
	if(on_ground){
		if(groundpounding){
			latest_groundpound_contact = global.t;
			groundpounding = false;
			global.freezeframe = groundpound_contact_freezeframe;
			obj_renderer.create_particles(10, x + sprite_width / 1.5, y + sprite_height * 1.5, 8, 30, true, (vel_x / -4) - 0.5, (vel_x / -4) + 0.5, -0.25, -0.75);
			activate_ring();
		}
		
		if(diving){
			latest_dive_contact = global.t;
			diving = false;
		}
		latest_ground_contact = global.t;
		groundpounding = false;
		jumping = false;
	} else if(!groundpounding
				&& global.t - latest_input_down_t < groundpound_buffer
				&& global.t - latest_jump_t > jump_groundpound_cooldown){
		vel_y = vel_groundpound;
		vel_x /= 2;
		groundpounding = true;
		jumping = false;
	} else if(global.t - latest_input_dive_t < dive_buffer
	&& global.t - latest_jump_t > jump_dive_cooldown
	&& global.t - latest_dive_contact > dive_cooldown
	&& !diving && !groundpounding){
		diving = true;
		latest_input_dive_t = global.t;
		latest_dive_t = global.t;
		global.freezeframe = dive_freezeframe;
	} else if(jumping && !groundpounding && input_y == 1 && global.t - latest_jump_t < jump_duration){
		vel_y += sqrt(jump_height) * jump_mult / jump_duration;
	} else {
		// jumping = false;
	}
	
	if(!jumping && global.t - latest_input_up_t < jump_buffer
	&& (on_ground || global.t - latest_ground_contact < coyote_time)){
		vel_y = (sqrt(jump_height) / jump_duration + jump_base) * jump_mult;
		if(global.t - latest_groundpound_contact < groundpound_jump_buffer){
			vel_y += groundpound_jump_boost;
		}
		latest_jump_t = global.t;
		jumping = true;
	}
    
	var step = 200;
	for(var i = 0; i < abs(vel_y) * step; i++){
		var vel_sign = -1 * sign(vel_y) / step;
		if(place_meeting(x, y + vel_sign * 2, obj_wall)){
			on_ground = (vel_y < 0);
			vel_y = 0;
			break;
		} else {
			on_ground = false;
		}
		y += vel_sign;
	}

	vel_y += grav;

	for(var i = 0; i < abs(vel_x) * step; i++){
		var vel_sign = sign(vel_x);
		if(place_meeting(x + vel_sign / step * 2, y, obj_wall)){
			curr_wall_contact_duration++;
			if(input_x != vel_sign || curr_wall_contact_duration > wall_momentum_break_time){
				vel_x = 0;			
			}
			break;
		} else {
			curr_wall_contact_duration = 0;
		}
		x += vel_sign / step;
	}
	vel_x *= on_ground ? decel_air : decel_air;
}

if(abs(vel_x) < vel_x_stopping_bound){
	vel_x = 0;
}

if(y > room_height || place_meeting(x, y, obj_kill)){
	x = spawnpoint[0];
	y = spawnpoint[1];
	vel_x = 0;
	vel_y = 0;
	jumping = true;
	groundpounding = false;
	diving = false;
	latest_groundpound_contact = global.t;
	global.freezeframe = 15;
}

//camera_set_view_pos(view_camera[0], x, y);
var view_pos_x =  x - (camera_get_view_width(view_camera[0]) - sprite_width) / 2;
var view_pos_y = y - (camera_get_view_height(view_camera[0]) - sprite_height) / 2;

if(global.t - latest_groundpound_contact < groundpound_screenshake_duration){
	view_pos_x += random_range(-1 * groundpound_screenshake_strength, groundpound_screenshake_strength);
	view_pos_y += random_range(-1 * groundpound_screenshake_strength, groundpound_screenshake_strength);
}

if(global.t - latest_dive_t < dive_screenshake_duration){
	view_pos_x += random_range(-1 * dive_screenshake_strength, dive_screenshake_strength);
	view_pos_y += random_range(-1 * dive_screenshake_strength, dive_screenshake_strength);
}

camera_set_view_pos(view_camera[0], view_pos_x, view_pos_y);

if(right_pressed)
latest_input_right_t = global.t;

if(left_pressed)
latest_input_left_t = global.t;

if(latest_input_right_t > latest_input_left_t){
	latest_input_x = 1;
} else if(latest_input_right_t < latest_input_left_t){
	latest_input_x = -1;
} else {
	latest_input_x = 0;
}

if(groundpounding){
	image_index = 3;
} else if(diving && global.t - latest_input_dive_t >= dive_freezeframe){
	image_index = 5 + (dive_dir - 1) / 2;
} else if(jumping && vel_y >= -0.2){
	image_index = 0;
} else if(input_x != 0){
	image_index = (global.t / 8) % 3;
} else {
	image_index = 1;
}

function activate_ring(){
	obj_renderer.ring_active = true;
	obj_renderer.ring_radius = 40;
	obj_renderer.ring_pos_x = camera_get_view_width(view_camera[0]) / 2; //x + (sprite_get_width(sprite_index) / 2);
	obj_renderer.ring_pos_y = camera_get_view_width(view_camera[0]) / 2; //y + (sprite_get_height(sprite_index) / 2);
}

function unstuck(strength){
	dirs = [[0, 1], [0, -1], [1, 0], [-1, 0]]
	for(var i = 1; i <= strength; i++){
		for(var j = 0; j < 4; j++){
			x += dirs[j] * i;
			y += dirs[j] * i;
			
			if(place_meeting(x, y, obj_wall)){
				return;
			}
			
			x -= dirs[0] * i;
			y -= dirs[1] * i;
		}
	}
}
