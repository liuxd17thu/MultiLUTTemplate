#include "MultiLUTHeader.fxh"
#include "ReShade.fxh"

#define fLUT_Selections "\
Neutral\0\
Color1\0\
Color2\0\
Color3 (Blue oriented)\0\
Color4 (Hollywood)\0\
Color5\0\
Color6\0\
Color7\0\
Color8\0\
Cool light\0\
Flat & green\0\
Red lift matte\0\
Cross process\0\
Azure Red Dual Tone\0\
Sepia\0\
B&W mid constrast\0\
B&W high contrast\0\
"

MultiLUT_SUMMONING(ReShade, "MultiLut_atlas1.png", 32, 32, 18, fLUT_Selections)