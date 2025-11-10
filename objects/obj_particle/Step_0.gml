curr_size -= (size / lifespan);

image_xscale = curr_size / width;
image_yscale = curr_size / height;
show_debug_message(string(sprite_width) + ", " + string(sprite_width));

pos_x += vel_x;
pos_y += vel_y;

x = pos_x - (curr_size / 2);
y = pos_y - (curr_size / 2);

curr_lifespan--;

if(curr_lifespan < 0){
	instance_destroy();
}

visible = true;