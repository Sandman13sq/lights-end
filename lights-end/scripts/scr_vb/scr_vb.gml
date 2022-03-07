/*
*/

#macro VBF3D global.g_vbf3d
vertex_format_begin();
vertex_format_add_position_3d();
vertex_format_add_normal();
vertex_format_add_color();
vertex_format_add_texcoord();
VBF3D = vertex_format_end();

function LoadVB(path)
{
	var b = buffer_load(filename_change_ext(path, ".vb"));
	
	if (b == -1)
	{
		show_message("Error loading VB from " + string(path));
		return -1;
	}
	
	var bdecomp = buffer_decompress(b);
	buffer_delete(b);
	
	var vb = vertex_create_buffer_from_buffer(bdecomp, VBF3D);
	buffer_delete(bdecomp);
	
	return vb;
}
