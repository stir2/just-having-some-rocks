var active_tracks = stage_complete_seq_instance.activeTracks;

// assign the object variables.
// this only runs once but can't be with create because the things don't exist yet
if (!objects_assigned) {
	// for every folder in the sequence
	for (var folder = 0; folder < array_length(active_tracks); folder++) {
		var subtracks = active_tracks[folder].track.tracks;

		// for every thing in that folder
		for (var track = 0; track < array_length(subtracks); track++) {
			var current_track = subtracks[track];
			var textbox = current_track.keyframes[0].channels[0]
		
			// if the folder is the run timer
			switch (current_track.name) {
				case "run timer":
					run_timer = textbox;
				break;
				
				case "STAGE NAME":
					textbox.text = room_get_name(global.current_room);
				break;
				
				case "death counter":
					death_counter = textbox;
				break;
				
				case "secrets found": 
					secrets_conter = textbox;
					secrets_conter.text = "0/" + string(secrets_max);
				break;
				
				case "Rank":
					rank_textbox = textbox;
					rank_textbox.text = rank;
				break;
			}
		}
	}
	
	
	objects_assigned = true
}

// we only want one thing counting at a time, so everyting is else if

// count up the timer
if (timer_ms < global.previous_stage_completion_time) {
	timer_ms += int64(global.previous_stage_completion_time/60)
	run_timer.text = format_time(timer_ms)
	
// timer final fix (for easing overshoot)
} else if (timer_ms > global.previous_stage_completion_time) {
	timer_ms = global.previous_stage_completion_time
	run_timer.text = format_time(timer_ms)
	
// count up deaths
} else if (deaths_written < deaths_total) {
	deaths_written += choose(0, 1) // yep this is the best way to make it go slower for sure
	death_counter.text = deaths_written
	
// secrets counter
} else if (secrets_written < secrets_total) {
	secrets_written += choose(0, 1) 
	secrets_conter.text = string(secrets_written) + "/" + string(secrets_max)
}
