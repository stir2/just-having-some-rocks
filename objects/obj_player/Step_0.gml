var input_x = keyboard_check(vk_right) - keyboard_check(vk_left);
var input_y = keyboard_check(vk_down) - keyboard_check(vk_up);

var moveSpeed = 3;
x += input_x * moveSpeed;
y += input_y * moveSpeed;
