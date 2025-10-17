// Fragment Shader for Vertical Gaussian Blur
varying vec2 v_vTexcoord;
uniform sampler2D u_sTex;
uniform float u_fBlurSize; // Controls the blur radius

void main()
{
    vec4 sum = vec4(0.0);
    float blurAmount = u_fBlurSize / textureSize(u_sTex, 0).y; // Adjust blur size based on texture height

    // Gaussian weights (simplified example, you can use more precise weights)
    float weight[5] = float[](0.227027, 0.1945946, 0.1216216, 0.054054, 0.016216);

    sum += texture2D(u_sTex, v_vTexcoord) * weight[0];
    sum += texture2D(u_sTex, v_vTexcoord - vec2(0.0, blurAmount * 1.0)) * weight[1];
    sum += texture2D(u_sTex, v_vTexcoord + vec2(0.0, blurAmount * 1.0)) * weight[1];
    sum += texture2D(u_sTex, v_vTexcoord - vec2(0.0, blurAmount * 2.0)) * weight[2];
    sum += texture2D(u_sTex, v_vTexcoord + vec2(0.0, blurAmount * 2.0)) * weight[2];
    sum += texture2D(u_sTex, v_vTexcoord - vec2(0.0, blurAmount * 3.0)) * weight[3];
    sum += texture2D(u_sTex, v_vTexcoord + vec2(0.0, blurAmount * 3.0)) * weight[3];
    sum += texture2D(u_sTex, v_vTexcoord - vec2(0.0, blurAmount * 4.0)) * weight[4];
    sum += texture2D(u_sTex, v_vTexcoord + vec2(0.0, blurAmount * 4.0)) * weight[4];

    gl_FragColor = sum;
}