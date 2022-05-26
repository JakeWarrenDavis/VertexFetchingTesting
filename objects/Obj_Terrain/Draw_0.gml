time+=DELTATIME;

//shader_set_texture_pixel(heightmap, 0,0,dsin(time*100),0,0,0);
shader_update_texture(heightmap);

shader_set(Shader_Terrain);
shader_set_texture(heightmap, 0);
shader_set_uniform_f_array(u_lightForward, lightDir);
vertex_submit(buffer,pr_trianglelist, sprite_get_texture(Spr_Grass, 0));
shader_reset();
