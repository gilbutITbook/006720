// ---------------------------------------------------------
// Basic_2D.fx
// Simple2D 셰이더 
// ---------------------------------------------------------


// 텍스처 
Texture2D Tex2D : register( t0 );		// 텍스처 

// 텍스처 샘플러 
SamplerState MeshTextureSampler : register( s0 )
{
    Filter = MIN_MAG_MIP_LINEAR;
    AddressU = Wrap;
    AddressV = Wrap;
};

// 상수 버퍼 
cbuffer cbNeverChanges : register( b0 )
{
    matrix View;
};


// VertexShader입력 형식 
struct VS_INPUT {
    float4 v4Position	: POSITION;		// 위치 
    float4 v4Color		: COLOR;		// 색
    float2 v2Tex		: TEXTURE;		// 텍스처 좌표 
};

// VertexShader출력 형식 
struct VS_OUTPUT {
    float4 v4Position	: SV_POSITION;	// 위치
    float4 v4Color		: COLOR;		// 색
    float2 v2Tex		: TEXTURE;		// 텍스처 좌표 
};

// 정점 셰이더 
VS_OUTPUT VS( VS_INPUT Input )
{
    VS_OUTPUT	Output;

    Output.v4Position = mul( Input.v4Position, View );
    Output.v4Color = Input.v4Color;
    Output.v2Tex = Input.v2Tex;

    return Output;
}

// 픽셀셰이더 
float4 PS( VS_OUTPUT Input ) : SV_TARGET {
    return Tex2D.Sample( MeshTextureSampler, Input.v2Tex ) * Input.v4Color;
}
