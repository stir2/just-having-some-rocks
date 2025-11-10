//
// static_effect.fsh
//

varying vec2 v_vTexcoord;
varying vec4 v_vColour;

uniform float t;
uniform vec2 cam_pos;
uniform vec2 display_size;
uniform float flashlight_radius;

/*vec3 colorKeys[5];

colorKeys[0] = vec3(0, 0, 170);
colorKeys[1] = vec3(0, 0, 180);
colorKeys[2] = vec3(255, 255, 255);
colorKeys[3] = vec3(50, 50, 50);
colorKeys[4] = vec3(250, 100, 170);*/

int particle_update_time = 8;

float hash12(vec2 p){
	// Hash a 2D coordinate into [0, 1)
	vec3 p3 = fract(vec3(p.xyx) * 0.1031);
    p3 += dot(p3, p3.yzx + 33.33);
    return fract((p3.x + p3.y) * p3.z);
}

// Pseudorandom generator
float random(vec2 st) {
    return hash12(st);
}

bool check_color(vec3 rgb, vec3 target){
	return distance(rgb, target / 255.0) < 0.01;
}

float parametric_blend(float n)
{
	// sqr was originally n * n. For better results i changed the exponent.
    float sqr = pow(n, 2.0);
    return (1.0) * sqr / (2.0 * (sqr - n) + 1.0);
}

void main() {
    vec4 baseColor = texture2D(gm_BaseTexture, v_vTexcoord);
    vec3 rgb = baseColor.rgb;
	float a = baseColor.a;
	vec3 new_rgb = rgb;
	
	float pixel_size = 4.0;
	vec2 st = floor((gl_FragCoord.xy) / pixel_size) * pixel_size;
	vec2 st2 = floor((gl_FragCoord.xy - cam_pos) / pixel_size) * pixel_size;
	
	// Collectible noise
	if(check_color(rgb, vec3(0, 0, 170))){
		float time_step = 4.0;
		float t2 = floor(t / time_step) * time_step;
		
		float r = random(st2 + t2) * 0.25;
		float g = random(st2 + t2) * 0.25;
		float b = random(st2 + t2) * 1.0;
		new_rgb = vec3(r, g, b);
	// Player dash noise
	} else if(check_color(rgb, vec3(0, 0, 180))){
		float time_step = 4.0;
		float t2 = floor(t / time_step) * time_step;
		
		float r = random(st2 + t2) * 0.5;
		float g = random(st2 + t2) * 1.0;
		float b = random(st2 + t2) * 1.0;
		new_rgb = vec3(r, g, b);
	// White object / wall noise
	} else if(check_color(rgb, vec3(255, 255, 255))){
		float time_step = 4.0;
		float t2 = floor(t / time_step) * time_step;
		
		float r = random(st2 + t2) * 1.5;
		float g = random(st2 + t2) * 1.5;
		float b = random(st2 + t2) * 1.5;
		new_rgb = vec3(r, g, b);
	// Player groundpound noise
	} else if(check_color(rgb, vec3(50, 50, 50))){
		float time_step = 4.0;
		float t2 = floor(t / time_step) * time_step;
		
		float r = random(st2 + t2) * 0.75;
		float g = random(st2 + t2) * 0.75;
		float b = random(st2 + t2) * 0.75;
		new_rgb = vec3(r, g, b);
	} else if(check_color(rgb, vec3(250, 100, 170))){
		float time_step = 2.0;
		float t2 = floor(t / time_step) * time_step;
		
		if(step(0.75, random(st2 + t2 + 1.0)) == 1.0){
			float r = random(st2 + t2) * 1.2;
			float g = random(st2 + t2) * 1.2;
			float b = random(st2 + t2) * 1.2;
			new_rgb = vec3(r, g, b);
		} else {
			new_rgb = vec3(0.0, 0.0, 0.0);
			a = 0.0;
		}

	}
	
	vec2 room_center = display_size / 2.0;
	float dist = distance(st, room_center);
	if(dist > flashlight_radius){
		new_rgb = rgb;
	}
	
    gl_FragColor = vec4(new_rgb, a);
}
