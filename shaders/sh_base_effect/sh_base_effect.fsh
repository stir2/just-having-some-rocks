//
// static_effect.fsh
//
varying vec2 v_vTexcoord;
varying vec4 v_vColour;

uniform float t;
uniform vec2 cam_pos;

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
	return distance(rgb, target / 255.0) < 0.05;
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
	vec2 pixel_pos = floor((gl_FragCoord.xy - cam_pos) / pixel_size) * pixel_size;
	
	//Collectible Animation
	if(check_color(rgb, vec3(0, 0, 170))){
		float time_step = 4.0;
		float t2 = floor(t / time_step) * time_step;
		
		float r = random(pixel_pos + t2) * 0.25;
		float g = random(pixel_pos + t2) * 0.25;
		float b = random(pixel_pos + t2) * 1.0;
		new_rgb = vec3(r, g, b);
	} else if(check_color(rgb, vec3(255, 255, 255))){
		float time_step = 4.0;
		float t2 = floor(t / time_step) * time_step;
		
		float r = random(pixel_pos + t2) * 1.5;
		float g = random(pixel_pos + t2) * 1.5;
		float b = random(pixel_pos + t2) * 1.5;
		new_rgb = vec3(r, g, b);
	}
	
    gl_FragColor = vec4(new_rgb, a);
}
