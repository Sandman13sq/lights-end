//
// Simple passthrough fragment shader
//
varying vec2 v_vTexcoord;
varying vec4 v_vColour;

uniform vec4 u_drawmatrix[4];	// [ [alpha emission 0 0] colorblend[4] colorfill[4]]

void main()
{
	vec4 basecolor = v_vColour * texture2D( gm_BaseTexture, v_vTexcoord );
	
	if (basecolor.a <= 0.1) {discard;}
	
	vec4 blendcolor = u_drawmatrix[0];
	vec4 fillcolor = u_drawmatrix[1];
	
	gl_FragColor = basecolor;
	
    gl_FragColor.rgb = mix(gl_FragColor.rgb, gl_FragColor.rgb * blendcolor.rgb, blendcolor.a);
    gl_FragColor.rgb = mix(gl_FragColor.rgb, fillcolor.rgb, fillcolor.a);
}
