// MultiLUT Template Header - by BarricadeMKXX
// Now it becomes a template, easier for publishing LUT textures I guess?
// Version - 1.0
// Based on Marty's LUT Shader - Otis Remaster of it - and lastly marots gshade version.

#define _CAT(x,y) x ## y
#define CAT(x,y) _CAT(x,y)

#define _STR(x) #x
#define STR(x) _STR(x)

#define MultiLUT_SUMMONING(NAME, fLUT_TextureName, fLUT_TileSizeXY, fLUT_TileAmount, fLUT_LutAmount, fLUT_Selections) \
\
uniform int fLUT_LutSelector < \
	ui_type = "combo"; \
	ui_items = fLUT_Selections; \
    ui_label = "LUT to use."; \
    ui_tooltip = "LUT to use for color transformation."; \
> = 0; \
\
uniform float fLUT_Intensity < \
    ui_type = "slider"; \
    ui_min = 0.00; ui_max = 1.00; \
    ui_label = "LUT Intensity"; \
    ui_tooltip = "Overall intesnity of the LUT effect."; \
> = 1.00; \
\
uniform float fLUT_AmountChroma < \
	ui_type = "slider"; \
	ui_min = 0.00; ui_max = 1.00; \
    ui_label = "LUT Chroma Amount"; \
    ui_tooltip = "Intensity of color/chroma change of the LUT."; \
> = 1.00; \
\
uniform float fLUT_AmountLuma < \
	ui_type = "slider"; \
	ui_min = 0.00; ui_max = 1.00; \
    ui_label = "LUT Luma Amount"; \
    ui_tooltip = "Intensity of luma change of the LUT."; \
> = 1.00; \
\
\
texture CAT(texMultiLUT_, NAME) < source = fLUT_TextureName; > { Width = fLUT_TileSizeXY*fLUT_TileAmount; Height = fLUT_TileSizeXY * fLUT_LutAmount; Format = RGBA8; }; \
sampler	CAT(SamplerMultiLUT_, NAME) { Texture = CAT(texMultiLUT_, NAME); }; \
\
\
\
void PS_MultiLUT_Apply(float4 vpos : SV_Position, float2 texcoord : TEXCOORD, out float4 res : SV_Target0) \
{ \
	float4 color = tex2D(ReShade::BackBuffer, texcoord.xy); \
	float2 texelsize = 1.0 / fLUT_TileSizeXY; \
	texelsize.x /= fLUT_TileAmount; \
\
	float3 lutcoord = float3((color.xy*fLUT_TileSizeXY-color.xy+0.5)*texelsize.xy,color.z*fLUT_TileSizeXY-color.z); \
	lutcoord.y /= fLUT_LutAmount; \
	lutcoord.y += (float(fLUT_LutSelector)/ fLUT_LutAmount); \
	float lerpfact = frac(lutcoord.z); \
	lutcoord.x += (lutcoord.z-lerpfact)*texelsize.y; \
\
	float3 lutcolor = lerp(tex2D(CAT(SamplerMultiLUT_, NAME), lutcoord.xy).xyz, tex2D(CAT(SamplerMultiLUT_, NAME), float2(lutcoord.x + texelsize.y, lutcoord.y)).xyz, lerpfact); \
	lutcolor = lerp(color.xyz, lutcolor, fLUT_Intensity); \
\
	color.xyz = lerp(normalize(color.xyz), normalize(lutcolor.xyz), fLUT_AmountChroma) *  \
	            lerp(length(color.xyz),    length(lutcolor.xyz),    fLUT_AmountLuma); \
\
	res.xyz = color.xyz; \
	res.w = 1.0; \
} \
\
\
\
\
technique CAT(MultiLUT_, NAME) \
< \
	ui_tooltip = "If you would like to make multiple passes with the same texture,\n" \
				 "first, copy the .fx file and rename it.\n" \
				 "Then, rename the first parameter inside MultiLUT_SUMMONING().\n" \
				 "For example, copy and rename MultiLUT_ReShade.fx, open and change \n" \
				 "the \"ReShade\" in the very last line into \"ReShade2\".\n" \
				 "Now you get a effect called \"MultiLUT_ReShade2\"!\n\n" \
				 "For preset/lut creators, see MultiLUT_Custom.fx to know how to publish your own MultiLUT_???.fx"; \
> \
{ \
	pass \
	{ \
		VertexShader = PostProcessVS; \
		PixelShader = PS_MultiLUT_Apply; \
	} \
}