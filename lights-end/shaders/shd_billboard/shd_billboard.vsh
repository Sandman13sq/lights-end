//
// Simple passthrough vertex shader
//
attribute vec3 in_Position;                  // (x,y,z)
attribute vec4 in_Colour;                    // (r,g,b,a)
attribute vec2 in_TextureCoord;              // (u,v)

varying vec2 v_vTexcoord;
varying vec4 v_vColour;

void main()
{
	vec4 object_space_pos = vec4( in_Position, 1.0);
	mat4 matWorldView = gm_Matrices[MATRIX_WORLD_VIEW];
	
	matWorldView[0][0] = 1.0;
	matWorldView[0][1] = 0.0;
	matWorldView[0][2] = 0.0;
	
	matWorldView[1][0] = 0.0;
	matWorldView[1][1] = -1.0;
	matWorldView[1][2] = 0.0;
	
	matWorldView[2][0] = 0.0;
	matWorldView[2][1] = 0.0;
	matWorldView[2][2] = 1.0;
	
	gl_Position = gm_Matrices[MATRIX_PROJECTION] * (matWorldView * object_space_pos);
	gl_Position.z -= 0.1;
	
	gl_Position.y *= -1.0;
    
    //gl_Position = gm_Matrices[MATRIX_WORLD_VIEW_PROJECTION] * object_space_pos;
    
    v_vColour = in_Colour;
    v_vTexcoord = in_TextureCoord;
}
