if(global.freezeframe > 0){
	global.freezeframe--;
}

global.t++;

if(keyboard_check_pressed(ord("T"))){
	global.debug = !global.debug;
}