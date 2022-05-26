// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function getHeight(_x, _y)
{
	var gridParts = 100;
	var gridSize = 64.0;
	var gridx;
	var gridy;
	//var offsetx;
	//var offsety;
	
	gridx = max(0, min(gridParts - 1, floor(_x / gridSize)));
	gridy = max(0, min(gridParts - 1, floor(_y / gridSize)));
	
	offsetx = _x - gridSize * gridx;
	offsety = _y - gridSize * gridy;
	
	var z1 = shader_get_texture_pixel(Obj_Terrain.heightmap, gridx, gridy, 0);
	var z2 = shader_get_texture_pixel(Obj_Terrain.heightmap, gridx + 1, gridy, 0);
	var z3 = shader_get_texture_pixel(Obj_Terrain.heightmap, gridx + 1, gridy + 1, 0);
	var z4 = shader_get_texture_pixel(Obj_Terrain.heightmap, gridx, gridy + 1, 0);
	
	var zz;
	if(offsetx > offsety)
	{
		//zz = z1 - offsety * (z2-z1) / gridSize - offsetx * (z4 - z1) / gridSize;
		//zz = z4 + (lerp(z3,z2,offsety) / gridSize) - (lerp(z3, z4, offsetx)/gridSize);
		zz = z1 + (lerp(z1,z2,offsetx) / gridSize) - (lerp(z3, z2, offsety)/gridSize);
	}
	else
	{
		//zz = z1 - offsetx * (z1-z2) / gridSize - offsety * (z1 - z4) / gridSize;
		zz = z1 + (lerp(z4,z3,offsetx) / gridSize) - (lerp(z4, z1, offsety)/gridSize);
	}
	return zz;
}