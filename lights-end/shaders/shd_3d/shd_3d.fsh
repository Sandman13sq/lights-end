//
// Simple passthrough fragment shader
//

varying vec3 v_vPosition;
varying vec3 v_vNormal;
varying vec4 v_vColour;
varying vec2 v_vTexcoord;

void main()
{
    gl_FragColor = v_vColour;
	//gl_FragColor.rgb = v_vNormal;
	gl_FragColor.a = 1.0;
}
