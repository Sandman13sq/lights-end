//
// Simple passthrough fragment shader
//

varying vec3 v_vPosition;
varying vec3 v_vNormal;
varying vec4 v_vColour;
varying vec2 v_vTexcoord;

uniform vec3 u_campos;

//[0.216667, -0.666667, 0.713170]
const vec3 u_lightdir = vec3(0.2, 0.6, 0.7);

// [0.600000, 0.300000, 1.000000, 1.000000]
const vec3 BURNCOLOR = vec3(0.6, 0.3, 1.0);

// Blender's version of color burn
vec3 ColorBurn(vec3 B, vec3 A, float fac)
{
	// return max(vec3(0.0), 1.0-((1.0-B)/A)) * fac + B * (1.0-fac); // Used in image editors like Photoshop
	return max(vec3(0.0), 1.0-((1.0-B)) / ( (1.0-fac) + (fac*A) ) ); // Used in Blender
}

void main()
{
	gl_FragColor = v_vColour * texture2D(gm_BaseTexture, v_vTexcoord);
	
	if (gl_FragColor.a <= 0.01) {discard;}
	
	float dp = dot(v_vNormal, normalize(u_lightdir));
	//dp *= pow(mix(0.7, 1.0, distance(u_campos, vec3(v_vPosition.xy, 0.0))/2000.0), 2.0);
	dp = float(int(dp*16.0))/16.0;
	
	gl_FragColor.rgb = mix(
		gl_FragColor.rgb,
		ColorBurn(gl_FragColor.rgb, BURNCOLOR, 1.0) * 0.5,
		dp
		);
	
	gl_FragColor.rgb = clamp(gl_FragColor.rgb, vec3(0.0), vec3(1.0));
	
	
	
}
