color = make_color_rgb(240, 240, 240)
if(crumbling){
	draw_sprite_part(sprite_index, 0, 0, 0, sprite_width, sprite_height * (1 - curr_destroy_duration / destroy_duration), x, y);
} else {
	draw_sprite(sprite_index, 0, x, y);
}