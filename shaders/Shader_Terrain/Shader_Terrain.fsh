//
// Simple passthrough fragment shader
//
//Output From Vertex Shader
struct PixelShaderInput
{
    float4 pos : SV_POSITION;
	float3 normals: NORMAL0;
    float4 color : COLOR0;
    float2 uv : TEXCOORD0;
};

uniform float3 u_lightForward;

//Main Program
float4 main(PixelShaderInput input) : SV_TARGET
{
    float4 vertColour = input.color;
    float4 texelColour = gm_BaseTextureObject.Sample(gm_BaseTexture, input.uv);
    float4 combinedColour = vertColour * texelColour;
	
	
	float3 lightDir = float3(1,1,-1);
	
	float illumination = -dot(input.normals, normalize(lightDir));
	combinedColour.rgb *= illumination;
	
	//combinedColour.rgb = input.normals;
    return combinedColour;
}
