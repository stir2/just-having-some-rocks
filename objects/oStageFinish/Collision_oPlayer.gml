// if this script has already fired, we don't care
if (global.stage_finished) {
	sprite_index = sStageComplete
	return
}

// change to the stage complete animation
// this would be better as a sequence, but it's here now so bleh
sprite_index = sStageComplete;
image_xscale = 4.5;
image_yscale = 4.5;

// tell everyone that the stage is finished.
global.stage_finished = true;

// calculate the time to complete
global.previous_stage_completion_time = (current_time - global.stage_start_time);

// align self with player
x = global.player.x
y = global.player.y