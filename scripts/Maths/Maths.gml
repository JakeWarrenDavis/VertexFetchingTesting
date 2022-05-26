function normalize(argument0)
{
	var un = argument0;
	
	var m = un[0]*un[0] + un[1]*un[1] + un[2]*un[2];
	
	var nv = array_create(3);
	nv[0] = un[0]/m;
	nv[1] = un[1]/m;
	nv[2] = un[2]/m;
	
	return nv;
}
