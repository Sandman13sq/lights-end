//
// Simple passthrough vertex shader
//
attribute vec3 in_Position;                  // (x,y,z)
attribute vec3 in_Normal;                  // (x,y,z)     unused in this shader.
attribute vec4 in_Colour;                    // (r,g,b,a)
attribute vec2 in_TextureCoord;              // (u,v)

varying vec3 v_vPosition;
varying vec3 v_vNormal;
varying vec4 v_vColour;
varying vec2 v_vTexcoord;

void main()
{
    vec4 vertexposition = vec4(in_Position, 1.0);
    vec4 vertexnormal = vec4(in_Normal, 0.0);
	
	//vertexposition.y *= -1.0;
	
	//vertexnormal.z *= -1.0;
	
	vertexposition.y -= vertexposition.z*0.5; // Skew y-coordinate
	
    gl_Position = gm_Matrices[MATRIX_WORLD_VIEW_PROJECTION] * vertexposition;
    
	v_vPosition = (vertexposition * gm_Matrices[MATRIX_WORLD]).xyz;
	
	v_vNormal = (vertexnormal * gm_Matrices[MATRIX_WORLD]).xyz;
    v_vColour = in_Colour;
    v_vTexcoord = in_TextureCoord;
	
}
