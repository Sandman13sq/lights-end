/// @desc 

vb = -1;
texture = -1;

function Load(path)
{
	vb = LoadVB(path);
}

function Draw()
{
	if (vb >= 0)
	{
		matrix_set(matrix_world, matrix_build(x, y, z, xrot, yrot, zrot, 1, 1, 1));
		vertex_submit(vb, pr_trianglelist, texture);
	}
}

x = 0;
y = 0;
z = 0;
xrot = 0;
yrot = 0;
zrot = 0;
