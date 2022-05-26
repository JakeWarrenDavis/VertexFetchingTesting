gpu_set_ztestenable(true);
gpu_set_zwriteenable(true);

//Initalize deltatime
globalvar DELTATIME, MOD;
DELTATIME = 1;
timeScale = 1;

gpu_set_tex_mip_filter(tf_anisotropic);
gpu_set_tex_max_aniso(16);
gpu_set_tex_filter(true);
display_reset(8, false);

var _info = os_get_info();
shader_set_device(_info[? "video_d3d11_device"],_info[? "video_d3d11_context"]);

instance_create_depth(0,0,100,Obj_Camera);
instance_create_depth(0,0,0,Obj_Terrain);
instance_create_depth(0,0,0,Obj_HeightTest);

//instance_create_depth(0,0,0,Obj_HeightTest);
//instance_create_depth(64,0,0,Obj_HeightTest);
//instance_create_depth(64,64,0,Obj_HeightTest);
//instance_create_depth(0,64,0,Obj_HeightTest);
