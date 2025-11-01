gpu_set_texfilter(false);
application_surface_draw_enable(true);
surf_static  = -1;
surf_bright  = -1;
surf_blur_h  = -1;
surf_blur_v  = -1;
surf_base = -1;

ring_active = false;
ring_pos_x = 0;
ring_pos_y = 0;
ring_radius = 0;
ring_cooldown = 0;
ring_max = 200;
flashlight_radius = 200;

particles = [];

function create_particles(count, pos_x, pos_y, size, lifespan, shader_visible, vel_x_lower, vel_x_upper, vel_y_lower, vel_y_upper){
	for(var i = 0; i < count; i++){
		var p = instance_create_layer(pos_x, pos_y, "Instances", obj_particle);
		p.pos_x = pos_x - (size / 2);
		p.pos_y = pos_y - (size / 2);
		p.size = size;
		p.curr_size = size;
		p.lifespan = lifespan;
		p.curr_lifespan = lifespan;
		p.shader_visible = shader_visible;
		p.vel_x = random_range(vel_x_lower, vel_x_upper);
		p.vel_y = random_range(vel_y_lower, vel_y_upper);
	}
}