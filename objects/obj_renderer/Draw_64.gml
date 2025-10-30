// Dimensions
var disp_w = display_get_gui_width();
var disp_h = display_get_gui_height();

var cam = view_camera[0];
var cam_w = camera_get_view_width(cam);
var cam_h = camera_get_view_height(cam);
var cam_x = camera_get_view_x(cam);
var cam_y = camera_get_view_y(cam);

// Create surfaces if they dont exist
if (!surface_exists(surf_static))  surf_static  = surface_create(disp_w, disp_h);
if (!surface_exists(surf_base))  surf_base  = surface_create(disp_w, disp_h);

surface_set_target(surf_base);

shader_set(sh_base_effect);

shader_set_uniform_f(shader_get_uniform(sh_base_effect, "t"), t);
shader_set_uniform_f(shader_get_uniform(sh_base_effect, "cam_pos"), cam_x, cam_y);

draw_surface_stretched(application_surface, 0, 0, disp_w, disp_h);
//shader_reset();
surface_reset_target();
// Draw static effect
surface_set_target(surf_static);

shader_set(sh_static_effect);

shader_set_uniform_f(shader_get_uniform(sh_static_effect, "t"), t);

// Pass in  ring uniforms
shader_set_uniform_f(shader_get_uniform(sh_static_effect, "ring_active"), ring_active);
var ring_frag_radius = ring_radius * (disp_h / cam_h);
var ring_frag_x = ring_pos_x * (disp_w / cam_w);
var ring_frag_y = ring_pos_y * (disp_h / cam_h);

shader_set_uniform_f(shader_get_uniform(sh_static_effect, "ring_radius"), ring_frag_radius);
shader_set_uniform_f(shader_get_uniform(sh_static_effect, "ring_pos"), ring_frag_x, ring_frag_y);
shader_set_uniform_f(shader_get_uniform(sh_static_effect, "display_size"), disp_w, disp_h);


draw_surface_stretched(surf_base, 0, 0, disp_w, disp_h);
shader_reset();
surface_reset_target();

draw_surface(surf_static, 0, 0);