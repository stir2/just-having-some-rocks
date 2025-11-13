if(groundpounding){
	color = make_color_rgb(50, 50, 50);
} else if(diving || global.t - latest_dive_contact < dive_cooldown){
	color = make_color_rgb(0, 0, 180);
} else {
	color = make_color_rgb(255, 255, 255);
}

if(!global.debug){
    draw_sprite_ext(sprite_index, image_index, x, y, 1, 1, 0, color, 1);
    
} else {
    var _outline_color = c_red;
    var _bg_color = make_color_rgb(25, 25, 25);
    var _outline_thickness = 0.2;


    draw_sprite_ext(mask_index, image_index, x - _outline_thickness, y, image_xscale, image_yscale, image_angle, _outline_color, image_alpha);
    draw_sprite_ext(mask_index, image_index, x + _outline_thickness, y, image_xscale, image_yscale, image_angle, _outline_color, image_alpha);
    draw_sprite_ext(mask_index, image_index, x, y - _outline_thickness, image_xscale, image_yscale, image_angle, _outline_color, image_alpha);
    draw_sprite_ext(mask_index, image_index, x, y + _outline_thickness, image_xscale, image_yscale, image_angle, _outline_color, image_alpha);

    draw_sprite_ext(mask_index, image_index, x, y, image_xscale, image_yscale, image_angle, _bg_color, image_alpha);
    draw_sprite_ext(sprite_index, image_index, x, y, 1, 1, 0, color, 0.4);
}
