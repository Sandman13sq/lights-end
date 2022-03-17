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

function LoadVBA(path)
{
	var bcompressed = buffer_load(filename_change_ext(path, ".vba"));
	
	if (bcompressed == -1)
	{
		show_message("Error loading VBA from " + string(path));
		return -1;
	}
	
	var b = buffer_decompress(bcompressed);
	buffer_delete(bcompressed);
	
	// Read Data
	var n = buffer_read(b, buffer_u32);
	var vbname, namesize, vbsize, vbbytesize, vb;
	
	var vba = {
		vbs : array_create(n),
		names : array_create(n),
		count : n,
	}
	
	for (var i = 0; i < n; i++)
	{
		vbname = "";
		namesize = buffer_read(b, buffer_u8);
		
		repeat(namesize)
		{
			vbname += chr(buffer_read(b, buffer_u8));
		}
		vba.names[i] = vbname;
		
		vbsize = buffer_read(b, buffer_u32);
		vbbytesize = buffer_read(b, buffer_u32);
		
		vb = vertex_create_buffer_from_buffer_ext(b, VBF3D, buffer_tell(b), vbsize);
		
		buffer_seek(b, buffer_seek_relative, vbbytesize);
		
		vba.vbs[i] = vb;
		vba[$ vbname] = vb;
	}
	
	buffer_delete(b);
	
	return vba;
}
