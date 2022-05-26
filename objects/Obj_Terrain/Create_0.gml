textureSize = 1024;
cellSize = 64;
cellNum = 100;
time = 0;

vertex_format_begin();
vertex_format_add_position_3d();
vertex_format_add_normal();
vertex_format_add_color();
vertex_format_add_texcoord();
vertex_format_add_texcoord();
vertex_format_add_normal(); //Triangle point. Used to determine if we are in triangle 1 or 2 in the shader.
format = vertex_format_end();

buffer = vertex_create_buffer();
vertex_begin(buffer, format);

for(xx = 0; xx < cellNum; xx++)
{
	for(yy = 0; yy < cellNum; yy++)
	{
		var x1 = xx * cellSize;
		var x2 = (xx * cellSize) + cellSize;
		var y1 = yy * cellSize;
		var y2 = (yy * cellSize) + cellSize;
		
		//Add a cell.
		vertex_position_3d(buffer,x1,y1,0);
		vertex_normal(buffer,0,0,1);
		vertex_color(buffer, c_white, 1);
		vertex_texcoord(buffer, 0, 0);
		vertex_texcoord(buffer, xx, yy);
		vertex_float3(buffer, 0, 0, 0);
		
		vertex_position_3d(buffer,x2,y1,0);
		vertex_normal(buffer,0,0,1);
		vertex_color(buffer, c_white, 1);
		vertex_texcoord(buffer, 1, 0);
		vertex_texcoord(buffer, xx+1, yy);
		vertex_float3(buffer, 1, 0, 0);
		
		vertex_position_3d(buffer,x2,y2,0);
		vertex_normal(buffer,0,0,1);
		vertex_color(buffer, c_white, 1);
		vertex_texcoord(buffer, 1, 1);
		vertex_texcoord(buffer, xx+1, yy+1);
		vertex_float3(buffer, 1, 1, 0);
		
		vertex_position_3d(buffer,x2,y2,0);
		vertex_normal(buffer,0,0,1);
		vertex_color(buffer, c_white, 1);
		vertex_texcoord(buffer, 1, 1);
		vertex_texcoord(buffer, xx+1, yy+1);
		vertex_float3(buffer, 1, 1, 1);
		
		vertex_position_3d(buffer,x1,y2,0);
		vertex_normal(buffer,0,0,1);
		vertex_color(buffer, c_white, 1);
		vertex_texcoord(buffer, 0, 1);
		vertex_texcoord(buffer, xx, yy+1);
		vertex_float3(buffer, 0, 1, 1);
		
		vertex_position_3d(buffer,x1,y1,0);
		vertex_normal(buffer,0,0,1);
		vertex_color(buffer, c_white, 1);
		vertex_texcoord(buffer, 0, 0);
		vertex_texcoord(buffer, xx, yy);
		vertex_float3(buffer, 0, 0, 1);
	}
}

vertex_end(buffer);
vertex_freeze(buffer);

heightmap = shader_create_vertex_texture(cellNum,cellNum,0);

light_matrix=matrix_build_lookat(0,0,0,0,0,10,0,0,1);
lightDir[0] = light_matrix[0];
lightDir[1] = light_matrix[1];
lightDir[2] = light_matrix[2];
normalize(lightDir);
u_lightForward = shader_get_uniform(Shader_Terrain, "u_lightForward");
