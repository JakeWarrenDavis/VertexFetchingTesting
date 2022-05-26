//
// Simple passthrough vertex shader
//
//Input from Vertices
struct VertexShaderInput
{
	float3 pos : POSITION;
	float3 normals: NORMAL0;
	float4 color : COLOR0;
	float2 uv : TEXCOORD0;
	float2 huv : TEXCOORD1;
	float3 tuv : NORMAL1;
};
//Output Struct to Pixel Shader
struct VertexShaderOutput
{
	float4 pos : SV_POSITION;
	float3 normals: NORMAL0;
	float4 color : COLOR0;
	float2 uv : TEXCOORD0;
};

Texture2D myTexture : register( t0 );


//Get the terrain height at a vertex. Same as what you'd do on the cpu side of things, just remade in this vertex shader.
float getHeight(float _x, float _y)
{
	int gridParts = 100;
	float gridSize = 64.0;
	int gridx;
	int gridy;
	float offsetx;
	float offsety;
	
	gridx = max(0, min(gridParts - 1, floor(_x / gridSize)));
	gridy = max(0, min(gridParts - 1, floor(_y / gridSize)));
	
	offsetx = _x - gridSize * gridx;
	offsety = _y - gridSize * gridy;
	
	float z1 = myTexture[uint2(gridx,gridy)].r;
	float z2 = myTexture[uint2(gridx + 1,gridy)].r;
	float z3 = myTexture[uint2(gridx + 1,gridy + 1)].r;
	float z4 = myTexture[uint2(gridx,gridy + 1)].r;
	
	float zz;
	if(offsetx > offsety)
	{
		//zz = z1 - offsetx * (z1-z2) / gridSize - offsety * (z2 - z3) / gridSize;
		//zz = z4 + offsety * (z2-z3) / gridSize - offsetx * (z4 - z3) / gridSize;
		zz = z1 + (lerp(z1,z2,offsetx) / gridSize) - (lerp(z3, z2, offsety)/gridSize);
	}
	else
	{
		//zz = z1 - offsetx * (z4-z3) / gridSize - offsety * (z1 - z4) / gridSize;
		//zz = z1 - offsetx * (z1-z2) / gridSize - offsety * (z1 - z4) / gridSize;
		zz = z1 + (lerp(z4,z3,offsetx) / gridSize) - (lerp(z4, z1, offsety)/gridSize);
	}
	return zz;
	
}



float3 getNormal(float _x, float _y)
{
	float gridSize = 64.0;
	float xx, yy, zz;
	xx = getHeight(_x - gridSize, _y) - getHeight(_x + gridSize, _y);
	yy = getHeight(_x, _y - gridSize) - getHeight(_x, _y + gridSize);
	zz = gridSize * 2.0;
	
	return normalize(float3(xx,yy,zz));
}

float3 getNormal2(float _x, float _y, float3 UV)
{
	int gridParts = 100;
	float gridSize = 64.0;
	int gridx;
	int gridy;
	float offsetx;
	float offsety;
	
	gridx = max(0, min(gridParts - 1, floor(_x / gridSize)));
	gridy = max(0, min(gridParts - 1, floor(_y / gridSize)));
	
	offsetx = _x - gridSize * gridx;
	offsety = _y - gridSize * gridy;
	
	//float3 p1 = float3(_x - (gridSize * UV.x),                    _y - (gridSize * UV.y),                                myTexture[uint2(gridx,gridy)].r);
	//float3 p2 = float3((_x + gridSize) - (gridSize * UV.x),       _y - (gridSize * UV.y),                                myTexture[uint2(gridx+1,gridy)].r);
	//float3 p3 = float3((_x + gridSize) - (gridSize * UV.x),       (_y + gridSize) - (gridSize * UV.y),                    myTexture[uint2(gridx+1,gridy+1)].r);
	//float3 p4 = float3(_x - (gridSize * UV.x),                    (_y + gridSize) - (gridSize * UV.y),                    myTexture[uint2(gridx,gridy+1)].r);
	
	float3 normie = float3(0.0,0.0,1.0);
	
	if((int)UV.x == 0 && (int)UV.y == 0 && (int)UV.z == 0)
	{
		float3 p1 = float3(_x, _y, myTexture[uint2(gridx,gridy)].r);
		float3 p2 = float3(_x + gridSize, _y, myTexture[uint2(gridx + 1,gridy)].r);
		float3 p3 = float3(_x + gridSize, _y + gridSize, myTexture[uint2(gridx+1,gridy + 1)].r);
		
		
		float3 U = p1 - p2;
		float3 V = p1 - p3;
		
		
		normie = float3(U.z * V.y - U.y * V.z,        U.y * V.x - U.x * V.y,          U.x * V.z - U.z * V.x);
	}
	
	if((int)UV.x == 1 && (int)UV.y == 0 && (int)UV.z == 0)
	{
		float3 p1 = float3(_x, _y, myTexture[uint2(gridx,gridy)].r);
		float3 p2 = float3(_x - gridSize, _y, myTexture[uint2(gridx - 1,gridy)].r);
		float3 p3 = float3(_x + gridSize, _y + gridSize, myTexture[uint2(gridx,gridy + 1)].r);
		
		
		float3 U = p1 - p2;
		float3 V = p1 - p3;
		
		
		normie = -float3(U.z * V.y - U.y * V.z,        U.y * V.x - U.x * V.y,          U.x * V.z - U.z * V.x);
	}
	
	if((int)UV.x == 1 && (int)UV.y == 1 && (int)UV.z == 0)
	{
		float3 p1 = float3(_x, _y, myTexture[uint2(gridx,gridy)].r);
		float3 p2 = float3(_x - gridSize, _y - gridSize, myTexture[uint2(gridx-1,gridy - 1)].r);
		float3 p3 = float3(_x, _y - gridSize, myTexture[uint2(gridx,gridy-1)].r);
		
		
		float3 U = p1 - p2;
		float3 V = p1 - p3;
		
		
		normie = float3(U.z * V.y - U.y * V.z,        U.y * V.x - U.x * V.y,          U.x * V.z - U.z * V.x);
	}
	
	
	if((int)UV.x == 0 && (int)UV.y == 0 && (int)UV.z == 1)
	{
		float3 p1 = float3(_x, _y, myTexture[uint2(gridx,gridy)].r);
		float3 p2 = float3(_x + gridSize, _y + gridSize, myTexture[uint2(gridx + 1,gridy + 1)].r);
		float3 p3 = float3(_x, _y + gridSize, myTexture[uint2(gridx,gridy + 1)].r);
		
		
		float3 U = p1 - p2;
		float3 V = p1 - p3;
		
		
		normie = float3(U.z * V.y - U.y * V.z,        U.y * V.x - U.x * V.y,          U.x * V.z - U.z * V.x);
	}
	
	if((int)UV.x == 1 && (int)UV.y == 1 && (int)UV.z == 1)
	{
		float3 p1 = float3(_x, _y, myTexture[uint2(gridx,gridy)].r);
		float3 p2 = float3(_x - gridSize, _y - gridSize, myTexture[uint2(gridx - 1,gridy - 1)].r);
		float3 p3 = float3(_x - gridSize, _y, myTexture[uint2(gridx-1,gridy)].r);
		
		
		float3 U = p1 - p2;
		float3 V = p1 - p3;
		
		
		normie = -float3(U.z * V.y - U.y * V.z,        U.y * V.x - U.x * V.y,          U.x * V.z - U.z * V.x);
	}
	
	if((int)UV.x == 0 && (int)UV.y == 1 && (int)UV.z == 1)
	{
		float3 p1 = float3(_x, _y, myTexture[uint2(gridx,gridy)].r);
		float3 p2 = float3(_x + gridSize, _y, myTexture[uint2(gridx + 1,gridy)].r);
		float3 p3 = float3(_x, _y - gridSize, myTexture[uint2(gridx,gridy-1)].r);
		
		
		float3 U = p1 - p2;
		float3 V = p1 - p3;
		
		
		normie = -float3(U.z * V.y - U.y * V.z,        U.y * V.x - U.x * V.y,          U.x * V.z - U.z * V.x);
	}
	
	
	//if(UV.x == 2)
	//{
		//float3 U = p1 - p3;
		//float3 V = p1 - p4;
		//normie = float3(U.z * V.y - U.y * V.z,        U.y * V.x - U.x * V.y,          U.x * V.z - U.z * V.x);
	//}
	/*
	if(UV.x == 3 && UV.y == 3)
	{
		float3 U = p1 - p3;
		float3 V = p1 - p4;
		normie = float3(U.z * V.y - U.y * V.z,        U.y * V.x - U.x * V.y,          U.x * V.z - U.z * V.x);
	}
	
	if(UV.x == 2 && UV.y == 3)
	{
		float3 U = p1 - p3;
		float3 V = p1 - p4;
		normie = float3(U.z * V.y - U.y * V.z,        U.y * V.x - U.x * V.y,          U.x * V.z - U.z * V.x);
	}
	*/
	
	//normie = float3(0.0,0.0,0.0);
	return normalize(normie);
}

//Main Program
VertexShaderOutput main(VertexShaderInput input)
{
    VertexShaderOutput output;
    float4 pos = float4(input.pos, 1.0f);
	pos.z += myTexture[uint2(input.huv.x,input.huv.y)].r;

	//float3 world_space_norm = normalize(mul((float3x3)gm_Matrices[MATRIX_WORLD],input.normals));
	
	float3 newNorm = float3(0,0,1);
	/*
	if((int)input.uv.x == 0 && (int)input.uv.y == 0)
	{
		//Calculate face normals
		float h1 = myTexture[uint2(input.huv.x,input.huv.y)].r;
		float h2 = myTexture[uint2(input.huv.x+1,input.huv.y)].r;
		float h3 = myTexture[uint2(input.huv.x,input.huv.y+1)].r;
	
		float3 p1 = float3(pos.x,pos.y,h1);
		float3 p2 = float3(pos.x+1,pos.y,h2);
		float3 p3 = float3(pos.x,pos.y+1,h3);
	
		float3 U = p2 - p1;
		float3 V = p3 - p1;
	
		newNorm = cross(U,V);
	}
	
	if((int)input.uv.x == 1 && (int)input.uv.y == 1)
	{
		//Calculate face normals
		float h1 = myTexture[uint2(input.huv.x,input.huv.y)].r;
		float h2 = myTexture[uint2(input.huv.x,input.huv.y-1)].r;
		float h3 = myTexture[uint2(input.huv.x-1,input.huv.y)].r;
	
		float3 p1 = float3(pos.x,pos.y,h1);
		float3 p2 = float3(pos.x,pos.y-1,h2);
		float3 p3 = float3(pos.x-1,pos.y,h3);
	
		float3 U = p2 - p1;
		float3 V = p3 - p1;
	
		newNorm = cross(U,V);
	}
	
	if((int)input.uv.x == 1 && (int)input.uv.y == 0)
	{
		//Calculate face normals
		float h1 = myTexture[uint2(input.huv.x,input.huv.y)].r;
		float h2 = myTexture[uint2(input.huv.x,input.huv.y+1)].r;
		float h3 = myTexture[uint2(input.huv.x-1,input.huv.y)].r;
	
		float3 p1 = float3(pos.x,pos.y,h1);
		float3 p2 = float3(pos.x,pos.y+1,h2);
		float3 p3 = float3(pos.x-1,pos.y,h3);
	
		float3 U = p2 - p1;
		float3 V = p3 - p1;
	
		newNorm = cross(U,V);
	}
	
	if((int)input.uv.x == 0 && (int)input.uv.y == 1)
	{
		//Calculate face normals
		float h1 = myTexture[uint2(input.huv.x,input.huv.y)].r;
		float h2 = myTexture[uint2(input.huv.x+1,input.huv.y)].r;
		float h3 = myTexture[uint2(input.huv.x,input.huv.y-1)].r;
	
		float3 p1 = float3(pos.x,pos.y,h1);
		float3 p2 = float3(pos.x+1,pos.y,h2);
		float3 p3 = float3(pos.x,pos.y-1,h3);
	
		float3 U = p2 - p1;
		float3 V = p3 - p1;
	
		newNorm = cross(U,V);
	}
	*/
	float gridSize = 64.0;
	//Normal Calculations
	//Calculate face normals
	
	newNorm = getNormal2(pos.x,pos.y, input.tuv);
	
    // Transform the vertex position into projected space.
    pos = mul(gm_Matrices[MATRIX_WORLD_VIEW_PROJECTION], pos);
    output.pos = pos;
    // Pass through the color
    output.color = input.color;
    // Pass through uv
    output.uv = input.uv;
	
	
	output.normals = newNorm;
    
	return output;
}
