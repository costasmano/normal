//%attributes = {"invisible":true}
//Method: Compiler_SVG
//Description
//
// Parameters
// ----------------------------------------------------
If (False:C215)
	// ----------------------------------------------------
	//User name (OS): Costas Manousakis
	//User (4D) : Designer
	//Date and time: 09/02/15, 12:50:09
	// ----------------------------------------------------
	//Created : 
	Mods_2015_09
End if 
//
If (False:C215)
	C_TEXT:C284(SVG_ApplyScale; $1)
	C_REAL:C285(SVG_ApplyScale; $2)
	C_REAL:C285(SVG_ApplyScale; $3)
	
	C_PICTURE:C286(LTR_GetSVGVertCLRPic; $0)
	
	C_BOOLEAN:C305(SVG_ParseTextSource; $0)
	C_POINTER:C301(SVG_ParseTextSource; $1)
	C_POINTER:C301(SVG_ParseTextSource; $2)
	
	
	
	C_BOOLEAN:C305(SVG_FindSetTspan; $0)
	C_TEXT:C284(SVG_FindSetTspan; $1)
	C_TEXT:C284(SVG_FindSetTspan; $2)
	C_TEXT:C284(SVG_FindSetTspan; $3)
	
End if 

//End Compiler_SVG