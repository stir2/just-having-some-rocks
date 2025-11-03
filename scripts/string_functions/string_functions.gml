/// zero pad an input number with the number of zeros provided.
/// for example, zero_pad_number(27, 3) returns string "027"
function zero_pad_number(input_thing, number_of_zeros = 2){
	// put the thing at the end of a lot of zeros
	var zero_appended_thing = "000000000000" + string(input_thing)
	var output_string = ""
	var str_len = string_length(zero_appended_thing)
	
	// cut off everything but the digits we need
	for (var i = str_len - number_of_zeros + 1; i <= str_len; i++) {
		output_string += string_char_at(zero_appended_thing, i)
	}
	
	return output_string
}

/// takes a time in ms and converts it to string mm:ss.ms
function format_time(miliseconds) {
	var seconds = miliseconds div 1000
	miliseconds -= seconds * 1000

	var minutes = seconds div 60
	seconds -= minutes * 60

	var time_string = zero_pad_number(minutes) + ":" + zero_pad_number(seconds) + "." + zero_pad_number(miliseconds, 3)
	return time_string
}