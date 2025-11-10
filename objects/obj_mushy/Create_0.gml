vel_x = 0;
vel_x_stopping_bound = 0.1;
vel_y = 0;
decel_gnd = 0.4;
decel_air = 0.75;
accel_x = 0.5;
grav = -0.20;
wall_momentum_break_time = 4;
curr_wall_contact_duration = 0;


jump_base = 2;
jump_height = 5;
jump_mult = 1;
curr_jump_time = 0;
jump_duration = 10;
jump_buffer = 8;
coyote_time = 6;
jumping = false;

groundpound_buffer = 8;
vel_groundpound = -5;
jump_groundpound_cooldown = 6;
groundpound_jump_buffer = 10;
groundpound_jump_boost = 1.10;
groundpound_contact_freezeframe = 4;
groundpounding = false;
groundpound_screenshake_strength = 1;
groundpound_screenshake_duration = 8;

vel_dive_x = 6;
vel_dive_y = 1;
jump_dive_cooldown = 6;
dive_cooldown = 8;
dive_buffer = 8;
diving = false;
dive_freezeframe = 4;
dive_screenshake_strength = 0.5;
dive_screenshake_duration = 6;

input_x = 0;
input_y = 0;
latest_input_x = -1000;
latest_input_y = -1000;
latest_input_right_t = -1000;
latest_input_left_t = -1000;
latest_input_up_t = -1000;
latest_input_down_t = -1000;
latest_jump_t = -1000;
latest_ground_contact = -1000;
latest_input_dive_t = -1000;
latest_dive_t = -1000;
latest_groundpound_contact = -1000;
latest_dive_contact = -1000;
dive_dir = 0;

on_ground = false;
color = make_color_rgb(255, 255, 255);

depth = -2;
mask_index = spr_mushy_mask2;