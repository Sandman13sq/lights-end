/// @desc

// Restore state
shader_reset();

matrix_set(matrix_projection, roommats[0]);
matrix_set(matrix_view, roommats[1]);
matrix_set(matrix_world, roommats[2]);
	
gpu_pop_state();

