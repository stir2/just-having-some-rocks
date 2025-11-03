var stage_complete_sequence = layer_sequence_create(layer, room_width/2, room_height/2, seqStageResults);
stage_complete_seq_instance = layer_sequence_get_instance(stage_complete_sequence);
objects_assigned = false

// the current number counted, starts from zero and instances up)
timer_ms = 0
deaths_written = 0
secrets_written = 0

// filler data that will come from other script(s) later.
randomise()
deaths_total = int64(random(20))
secrets_max = int64(random(20))
secrets_total = int64(random(secrets_max))
rank = choose("S", "A", "B", "C", "D", "F")