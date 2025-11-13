if(global.t - obj_mushy.latest_groundpound_contact < player_destroy_buffer
&& (place_meeting(x + 4, y - 2, obj_mushy) || place_meeting(x - 4, y - 2, obj_mushy))){
	crumbling = true;
}

if(crumbling){
	curr_destroy_duration++;
	if(curr_destroy_duration > destroy_duration){
		instance_destroy();
	}
}