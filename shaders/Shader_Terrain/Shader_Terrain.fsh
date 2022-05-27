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
uniform float3 u_cameraPosition;

//Main Program
float4 main(PixelShaderInput input) : SV_TARGET
{
    float4 vertColour = input.color;
    float4 texelColour = gm_BaseTextureObject.Sample(gm_BaseTexture, input.uv);
    float4 combinedColour = vertColour * texelColour;
	
	float4 lightColour = float4(1.0,1.0,1.0,1.0);
	float4 ambient = lightColour * 0.2;
	ambient.a = 1.0;
	
	//float3 lightDir = float3(1,1,-1);
	float3 lightPos = float3(1000.0,2000.0,300.0);
	float3 lightDir =  normalize(lightPos-input.pos.xyz);
	
	lightDir = normalize(float3(1.0,0.0,0.0));
	
	float diff = max(-dot(input.normals,lightDir),0.0);
	float4 diffuse = diff * lightColour;
	diffuse.a = 1.0;
	
	
	float specularStrength = 0.5;
	float3 viewDir = normalize(u_cameraPosition - input.pos.xyz);
	float3 reflectDir = reflect(-lightDir, input.normals);

	float spec = pow(max(-dot(viewDir, reflectDir), 0.0), 32.0);
	float3 specular = specularStrength * spec * lightColour;
	float4 s_spec = float4(specular,1.0);

	//float illumination = -dot(input.normals, normalize(lightDir));
	//combinedColour.rgb *= illumination;
	
	//combinedColour.rgb = input.normals;
	
	
	combinedColour = texelColour *  (ambient+diffuse); //Removed specular, it looked weird.
    return combinedColour;
}
