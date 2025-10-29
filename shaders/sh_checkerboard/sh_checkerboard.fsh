
//
// static_effect.fsh
//
varying vec2 v_vTexcoord;
varying vec4 v_vColour;

// Pseudorandom generator
float random(vec2 st) {
    return fract(sin(dot(st.xy, vec2(12.9898, 78.233))) * 43758.5453123);
}

int getPixel(int x, int y) {
	if (x > 120 || y > 67) {
		return 0;
	}
	//return 0;
	//return img[x + 120 * y];
}

// Zero power tower, if negative return 0, if positive return 1
float zpt(float x) {
	if (x > 0.0) {
		return 1.0;
	}
	return 0.0;
}

// Distance function bc idk what gamemaker uses for distance functions
float dist(float x, float y) {
	//return (float) power(1.0, 1.0);
	return sqrt(x*x + y*y);
}

// Converts RGB on 0-255 scale to RGB on 0-1 scale
vec4 toRGB(vec3 col) {
	return vec4(col.x/255.0, col.y/255.0, col.z/255.0, 1.0);
}

vec3 colorBase(vec2 st, float colorSeed) {
	//vec3 base = new vec3(150 + 7.5 * random(st + vec2(colorSeed, 1.0)) * preserveBlack, 0, 0);
	float distort = 0.1 * dist(st.x, st.y) + 1.0 + 0.03 * sin(4.0 * st.x + 3.0 * st.y);
	float base = zpt((mod(1.3*(st.y - 0.2*st.x) / distort, 2.0) - 1.0) * (mod(1.3*(st.x + 0.2*st.y) / distort, 2.0) - 1.0));
	base = 1.5 * base / (0.5 * dist(st.x, st.y) + 1.0);
	//  + 50.0 * mod(atan(st.y, st.x), 3.141592653589793238 / 4.0
	float noise = 60.0 * random(st + vec2(colorSeed, 1.0));
	vec3 col = vec3(140.0, 150.0, 140.0);
	return base * col + noise * vec3(1.0, 1.0, 1.0);
	//float t = mod(5.0, 2.0);
	//return vec3(0.0, 0.0, 0.0);
	//blue: 20.0 * zpt(-4.0 + dist(st.x, st.y))
}



void main() {
    vec4 baseColor = texture2D(gm_BaseTexture, v_vTexcoord);
    vec3 rgb = baseColor.rgb;

    float pixelSize = 8.0;

    vec2 st = floor(gl_FragCoord.xy / pixelSize);

	// Luminance-based color seed
    float colorSeed = dot(rgb, vec3(0.299, 0.587, 0.114));
	
	// Zero if original pixel is black, 1 if anything else
	float preserveBlack = step(0.0001, dot(rgb, vec3(1, 1, 1)));
	
	float r = random(st + vec2(colorSeed, 1.0)) * preserveBlack;
    float g = random(st + vec2(colorSeed, 1.0)) * preserveBlack;
    float b = random(st + vec2(colorSeed, 1.0)) * preserveBlack;
	
	//vec3 colorBase = new vec3(
	// Transform the x and y coordinates
	// Centered coordinates
	float xNew = (st.x - 120.0) / 16.0;
	float yNew = (-1.0 * st.y + 67.0) / 16.0;
	//float xNew = (st.x - 200.0) / 24.0;
	//float yNew = (-1.0 * st.y + 120.0) / 24.0;
	
	//r = r;
	//g = g;
	//b = b;
	
	gl_FragColor = toRGB(colorBase(vec2(xNew, yNew), colorSeed));

    // --- grayscale static ---
    //gl_FragColor = vec4(r, g, b, 1.0);
}
