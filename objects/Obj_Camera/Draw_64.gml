draw_text(0,0,floor(x/64));





var arr = matrix_build_identity(); //World
draw_text(50,50, string(arr));

var arr2 = matrix_build_lookat(x,y,z,x+1,y,z,0,0,1);
//arr2 = matrix_get(matrix_view); //View
//arr2 = camera_get_view_mat( camera_get_active())

draw_text(50,100, string(arr2));

//var arr3 = matrix_get(matrix_projection);
//var arr3 = matrix_build_projection_perspective_fov( -cameraFov, -window_get_width()/window_get_height(), cameraNearPlane, cameraFarPlane);
//arr3 = camera_get_proj_mat( camera_get_active())
var arr3 = matrix_build_projection_perspective_fov( -cameraFov, -1920/1080, cameraNearPlane, cameraFarPlane);
draw_text(50,150, string(arr3));
