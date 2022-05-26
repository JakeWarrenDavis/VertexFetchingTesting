/// @description Update 
// You can write your code in this editor
cameraMatrix = matrix_build(x, y, z, xrot, yrot, zrot,1,1,1);
//cameraMatrix = matrix_multiply(cameraMatrix,Obj_Entity_Ship.boatMatrix);
//Camera movement and input.
if(cameraCapture)
{
    
	
	
    if(keyboard_check(ord("W")))
    {
        x += cameraSpeed*DELTATIME*cameraMatrix[0];
        y += cameraSpeed*DELTATIME*cameraMatrix[1];
        z += cameraSpeed*DELTATIME*cameraMatrix[2];
    }
        
    if(keyboard_check(ord("S")))
    {
        x -= cameraSpeed*DELTATIME*cameraMatrix[0];
        y -= cameraSpeed*DELTATIME*cameraMatrix[1];
        z -= cameraSpeed*DELTATIME*cameraMatrix[2];
    }
	if(keyboard_check(ord("D")))
    {
        x += cameraSpeed*DELTATIME*cameraMatrix[4];
        y += cameraSpeed*DELTATIME*cameraMatrix[5];
        z += cameraSpeed*DELTATIME*cameraMatrix[6];
    }
        
    if(keyboard_check(ord("A")))
    {
        x -= cameraSpeed*DELTATIME*cameraMatrix[4];
        y -= cameraSpeed*DELTATIME*cameraMatrix[5];
        z -= cameraSpeed*DELTATIME*cameraMatrix[6];
    }
    //Update camera look position.
    //Update yrot and zrot.
    yrot -= ((window_mouse_get_y()-window_get_height()/2)*DELTATIME)*5;
    zrot -= ((window_mouse_get_x()-window_get_width()/2)*DELTATIME)*5;
    
    //Cap yrot.
    yrot = max(min(self.yrot, cameraLimit), -cameraLimit);
    
    //Set the mouse to the center of the window.
    window_mouse_set(window_get_width()/2,window_get_height()/2);
	
	if(keyboard_check_pressed(vk_escape))
	{
		game_end();
	}
	
	if(mouse_check_button(mb_left))
	{
		var px = round(x/ Obj_Terrain.cellSize);
		var py = round(y/ Obj_Terrain.cellSize);
		shader_set_texture_pixel(Obj_Terrain.heightmap, px, py, shader_get_texture_pixel(Obj_Terrain.heightmap, px, py, 0) + 40*DELTATIME, 0, 0, 0);
	}
	
	if(mouse_check_button(mb_right))
	{
		var px = round(x / Obj_Terrain.cellSize);
		var py = round(y / Obj_Terrain.cellSize);
		shader_set_texture_pixel(Obj_Terrain.heightmap, px, py, shader_get_texture_pixel(Obj_Terrain.heightmap, px, py, 0) - 40*DELTATIME, 0, 0, 0);
	}
}
