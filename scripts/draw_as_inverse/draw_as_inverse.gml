/// simply put this in the draw loop of anything you want to be inverted.
/// note: This function includes draw_self().
function draw_as_inverse(){
	gpu_set_blendmode_ext_sepalpha(bm_inv_dest_color, bm_inv_src_color, bm_src_alpha, bm_inv_src_alpha);
	
	draw_self();

	gpu_set_blendmode(bm_normal);
}