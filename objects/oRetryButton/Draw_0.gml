if (room != rStageComplete) { return }

draw_self();
draw_set_font(font_PixelFont);
draw_set_halign(fa_center);
draw_set_valign(fa_center);
draw_text_transformed(x, y-4, "RETRY", 4, 4, 0);

var hw = sprite_width/2;
var hh = sprite_height/2;
var opacity_mod = 1;
if point_in_rectangle(mouse_x, mouse_y, x - hw, y - hh, x + hw, y + hh) {
	opacity_mod = 0.5;
}

if (revealing) {
	image_alpha = (current_time - reveal_start) * 2 * opacity_mod / 1000;
	
	if (image_alpha > 1) {
		image_alpha = 1;
		revealing = false;
	}
} else {
	image_alpha = opacity_mod;
}