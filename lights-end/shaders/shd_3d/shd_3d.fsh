//
// Simple passthrough fragment shader
//

varying vec3 v_vPosition;
varying vec3 v_vNormal;
varying vec4 v_vColour;
varying vec2 v_vTexcoord;

uniform vec4 u_uvbounds;	// [left, right, up, down]

void main()
{
    gl_FragColor = v_vColour * texture2D(gm_BaseTexture,
		vec2(
			mix(v_vTexcoord.x, u_uvbounds[0], u_uvbounds[2]),
			mix(v_vTexcoord.y, u_uvbounds[1], u_uvbounds[3])
		)
		);
	
	gl_FragColor = v_vColour * texture2D(gm_BaseTexture, v_vTexcoord);
	
	//gl_FragColor.rgb = v_vNormal;
	//gl_FragColor.a = 1.0;
	
	//gl_FragColor.a = 1.0;
	
	float p = 64.0;
	
	//gl_FragColor += vec4(pow(v_vTexcoord.x, p) + pow(v_vTexcoord.y, p));
	//gl_FragColor += vec4(pow(1.0-v_vTexcoord.x, p) + pow(1.0-v_vTexcoord.y, p));
	
	if (gl_FragColor.a <= 0.01) {discard;}
}
