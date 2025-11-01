//
// static_effect.fsh
//
#define MAX_PARTICLES 50

varying vec2 v_vTexcoord;
varying vec4 v_vColour;
uniform float t;

// Set ring variables
uniform bool ring_active;
uniform float ring_radius;
uniform vec2 ring_pos;
uniform float flashlight_radius;
float ring_update_speed = 1.0;
float ring_width = 200.0;
uniform vec2 display_size;

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

float parametric_blend(float n)
{
	// sqr was originally n * n. For better results i changed the exponent.
    float sqr = pow(n, 2.0);
    return (1.0) * sqr / (2.0 * (sqr - n) + 1.0);
}

void main() {
	float pixel_size = 4.0;
	vec2 st = floor(gl_FragCoord.xy / pixel_size) * pixel_size;
	vec2 TexCoord = st / display_size;
    vec4 baseColor = texture2D(gm_BaseTexture, TexCoord);
	
    vec3 rgb = baseColor.rgb;
	float a = baseColor.a;
	
	// Zero if original pixel is black, 1 if anything else
	float preserve_black = step(0.0001, dot(vec4(rgb, a), vec4(1, 1, 1, 1)));
	bool point_in_ring = abs(distance(gl_FragCoord.xy, ring_pos) - ring_radius) < ring_width / 2.0;
	bool point_in_object = (rgb.r + rgb.g + rgb.b > 2.97);
    
	vec2 room_center = display_size / 2.0;

	// Luminance-based color seed
    float colorSeed = dot(rgb, vec3(0.299, 0.587, 0.114));
	
	if(ring_active && point_in_object && point_in_ring){
	    colorSeed += random(vec2(floor(t / ring_update_speed) * ring_update_speed));
	}
	
	float r = random(st + vec2(colorSeed, 1.0));
    float g = random(st + vec2(colorSeed, 2.0));
    float b = random(st + vec2(colorSeed, 3.0));
	
	vec3 new_rgb;
	float new_a;
	float dist = distance(st, room_center);
	
	// Create center visibility area
	if(dist < flashlight_radius){
		new_rgb = mix(rgb, vec3(r, g, b), pow(dist / 200.0, 8.0));
		new_a = mix(a, 1.0, pow(dist / 200.0, 8.0));
	} else {
		new_rgb = vec3(r, g, b);
		new_a = 1.0;
	}
	
	float mult = preserve_black;
	
	new_rgb *= mult;

    // --- grayscale static ---
    gl_FragColor = vec4(new_rgb, new_a);
}
