var input_x = keyboard_check(vk_right) - keyboard_check(vk_left);
var input_y = keyboard_check(vk_down) - keyboard_check(vk_up);

var test_input = keyboard_check(vk_space);

var moveSpeed = 3;
x += input_x * moveSpeed;
y += input_y * moveSpeed;

var view_pos_x =  x - (camera_get_view_width(view_camera[0]) - sprite_width) / 2;
var view_pos_y = y - (camera_get_view_height(view_camera[0]) - sprite_height) / 2

camera_set_view_pos(view_camera[0], view_pos_x, view_pos_y);

if(test_input){
	if(obj_renderer.ring_cooldown == 0){
		obj_renderer.ring_active = true;
		obj_renderer.ring_pos_x = x + (sprite_get_width(sprite_index) / 2);
		obj_renderer.ring_pos_y = y + (sprite_get_height(sprite_index) / 2);
	}
}

//camera_set_view_pos(view_camera[0], x, y);