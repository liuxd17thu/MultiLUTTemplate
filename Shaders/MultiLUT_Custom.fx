#include "MultiLUTHeader.fxh"
#include "ReShade.fxh"

// See also "MultiLUT_ReShade.fx" for example usage.

// Here build the selector dropdown list.
// Nth line here -> NAME of the Nth "line of squares" in the MultiLUT file. for example:
// "Neutral\0\" will become "Neutral" in ReShade GUI.
// You may not use symbol \(backslash) or "(quote) in the NAME, and please always keep the "\0\" ending.
// Also avoid names starting with digits.
// Add or remove lines if you need.
// Line count here can be smaller than in MultiLUT file, but remember that you can only use MultiLUT lines which are given a NAME here.
#define fLUT_Selections "\
Neutral\0\
Color1\0\
Color2\0\
Color3\0\
Color4\0\
Color5\0\
Color6\0\
Color7\0\
Color8\0\
Color9\0\
Color10\0\
"

MultiLUT_SUMMONING( Custom, \ /* Give a unique postfix name to your MultiLUT. You may not use space or punctuations (except underline) */
                    "MultiLut_atlas1.png", \ /* MultiLUT file name. MultiLUT image goes into Texture folder. */
                    32, \ /* Size of a single square in MultiLUT, usually 32 pixels. */
                    32, \ /* How many "column of squares" are there in a MultiLUT file, usually 32 squares. */
                    18, \ /* How many "line of squares" are there in a MultiLUT file, varied bewteen different MultiLUTs. */
                    fLUT_Selections \ /* DO NOT CHANGE THIS */
                )