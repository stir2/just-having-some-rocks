var fade_speed = 1.07;
var start_alpha = 0.05;

if (global.stage_finished) {
	// if the stage has been completed
	if (image_alpha > 1) {
		
		// change the room and hide
		global.stage_finished = false;
		image_alpha = start_alpha;
		room = rStageComplete;
		visible = false;
		
	// if the stage hasn't been completed
	} else {
		
		// show and crank up (down?) the alpha
		visible = true;
		image_alpha *= fade_speed;
	}
	
} else {
	// default alpha
	image_alpha = start_alpha;
}