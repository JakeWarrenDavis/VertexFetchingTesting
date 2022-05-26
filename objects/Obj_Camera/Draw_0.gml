/// @description Draw the view
var mV = matrix_build_lookat( x, y, z, x+10*cameraMatrix[0], y+10*cameraMatrix[1], z+10*cameraMatrix[2], 0, 0, 1);
						 
var mP = matrix_build_projection_perspective_fov( -cameraFov, -window_get_width()/window_get_height(), cameraNearPlane, cameraFarPlane);

camera_set_view_mat( camera_get_active(), mV );
camera_set_proj_mat( camera_get_active(), mP );
camera_apply( camera_get_active() );
