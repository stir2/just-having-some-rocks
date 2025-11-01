if(groundpounding){
	color = make_color_rgb(50, 50, 50);
} else if(diving || global.t - latest_dive_contact < dive_cooldown){
	color = make_color_rgb(0, 0, 180);
} else {
	color = make_color_rgb(255, 255, 255);
}

draw_sprite_ext(sprite_index, 0, x, y, 1, 1, 0, color, 1);