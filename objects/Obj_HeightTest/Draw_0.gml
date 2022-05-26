z = getHeight(x,y);

pos = matrix_build(x,y,z,0,0,0,1,1,1);

shader_set(Shader_HeightTest);
matrix_set(matrix_world, pos);
vertex_submit(buffer, pr_trianglelist, -1);
matrix_set(matrix_world,matrix_build_identity());
shader_reset();

shader_set(Shader_HeightTest);
matrix_set(matrix_world, matrix_build_lookat(x,y,z,x+normal[0],y+normal[1],z+normal[2], 0, 0, 1));
vertex_submit(buffer2, pr_trianglelist, -1);
matrix_set(matrix_world,matrix_build_identity());
shader_reset();
