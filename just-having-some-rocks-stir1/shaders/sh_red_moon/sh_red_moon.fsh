
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

vec3 colorBase(vec2 st, float colorSeed, float preserveBlack) {
	//vec3 base = new vec3(150 + 7.5 * random(st + vec2(colorSeed, 1.0)) * preserveBlack, 0, 0);
	float redBase = 160.0 + 300.0 * random(st + vec2(colorSeed, 1.0)) * preserveBlack; // Noise static
	float expGradient = (1.0 - 0.3 * exp(-0.5 * pow(4.0 - dist(st.x, st.y), 2.0)));
	float expGradient2 = (1.0 - 0.5 * exp(-1.0 * pow(2.0 - dist(st.x + 5.0, st.y - 4.0), 2.0)));
	redBase = expGradient2 * expGradient * 10.0 * redBase / (23.0 - dist(st.x, st.y)); // Outward gradient
	float moon = zpt(4.0 - dist(st.x, st.y)) * (145.0 - dist(st.x - 2.5, st.y + 2.5) * (180.0 / 8.0));
	float moon2 = zpt(2.0 - dist(st.x + 5.0, st.y - 4.0)) * (120.0 - dist(st.x + 2.5 + 5.0, st.y - 2.5 - 4.0) * (180.0 / 8.0));
	return vec3(redBase + moon + moon2, 0.0, 0.0);
	//blue: 20.0 * zpt(-4.0 + dist(st.x, st.y))
}



void main() {
    vec4 baseColor = texture2D(gm_BaseTexture, v_vTexcoord);
    vec3 rgb = baseColor.rgb;

    float pixelSize = 4.0;
	float resize = pixelSize / 8.0;
	//

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
	//float xNew = (st.x - 120.0) / 16.0;
	//float yNew = (-1.0 * st.y + 67.0) / 16.0;
	float xNew = (resize * st.x - 200.0) / 24.0;
	float yNew = (-1.0 * resize * st.y + 120.0) / 24.0;
	
	//r = r;
	//g = g;
	//b = b;
	
	gl_FragColor = toRGB(colorBase(vec2(xNew, yNew), colorSeed, preserveBlack));

    // --- grayscale static ---
    //gl_FragColor = vec4(r, g, b, 1.0);
}
