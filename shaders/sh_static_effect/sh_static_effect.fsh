//
// static_effect.fsh
//
varying vec2 v_vTexcoord;
varying vec4 v_vColour;

// Pseudorandom generator
float random(vec2 st) {
    return fract(sin(dot(st.xy, vec2(12.9898, 78.233))) * 43758.5453123);
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
    float g = random(st + vec2(colorSeed, 2.0)) * preserveBlack;
    float b = random(st + vec2(colorSeed, 3.0)) * preserveBlack;

    // --- grayscale static ---
    gl_FragColor = vec4(r, g, b, 1.0);
}
