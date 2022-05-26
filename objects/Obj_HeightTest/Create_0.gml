width = 16;
height = 32;
z = 0;
pos = matrix_build(x,y,z,0,0,0,1,1,1);

offsetx = 0;
offsety = 0;

vertex_format_begin();
vertex_format_add_position_3d();
vertex_format_add_color();
format = vertex_format_end();

buffer = vertex_create_buffer();
vertex_begin(buffer, format);

vertex_position_3d(buffer, 0,0,0);
vertex_color(buffer, c_red, 1);
vertex_position_3d(buffer, width,0,0);
vertex_color(buffer, c_green, 1);
vertex_position_3d(buffer, width,height,10);
vertex_color(buffer, c_blue, 1);

p1[0] = 0;
p1[1] = 0;
p1[2] = 0;

p2[0] = width;
p2[1] = 0;
p2[2] = 0;

p3[0] = width;
p3[1] = height;
p3[2] = 10;

A[0] = p1[0]-p2[0];
A[1] = p1[1]-p2[1];
A[2] = p1[2]-p2[2];

B[0] = p1[0]-p3[0];
B[1] = p1[1]-p3[1];
B[2] = p1[2]-p3[2];

//Nx = Ay * Bz - Az * By
//Ny = Az * Bx - Ax * Bz
//Nz = Ax * By - Ay * Bx

normal[0] = A[2] * B[1] - A[1] * B[2];
normal[1] = A[1] * B[0] - A[0] * B[1];
normal[2] = A[0] * B[2] - A[2] * B[0];

normal=normalize(normal);



/*
vertex_position_3d(buffer, -width/2,0,height/2);
vertex_color(buffer, c_red, 1);
vertex_position_3d(buffer, width/2,0,-height/2);
vertex_color(buffer, c_green, 1);
vertex_position_3d(buffer, -width/2,0,-height/2);
vertex_color(buffer, c_blue, 1);
*/
vertex_end(buffer);
vertex_freeze(buffer);




buffer2 = vertex_create_buffer();
vertex_begin(buffer2, format);

vertex_position_3d(buffer2, 0,0,0);
vertex_color(buffer2, c_red, 1);
vertex_position_3d(buffer2, width,0,0);
vertex_color(buffer2, c_green, 1);
vertex_position_3d(buffer2, width,height,0);
vertex_color(buffer2, c_blue, 1);
/*
vertex_position_3d(buffer, -width/2,0,height/2);
vertex_color(buffer, c_red, 1);
vertex_position_3d(buffer, width/2,0,-height/2);
vertex_color(buffer, c_green, 1);
vertex_position_3d(buffer, -width/2,0,-height/2);
vertex_color(buffer, c_blue, 1);
*/
vertex_end(buffer2);
vertex_freeze(buffer2);
