//%attributes = {"invisible":true}
//Method: SVG_GetALLObjects
//Description
// get ALL objects inside an SVG reference - dig into groups

// Parameters
// $1 : $svgref
// $2 : $objRefarray_ptr  (2-4 : pointers to string arrays)
// $3 : $objTypeArray_ptr
// $4 : $objIDarray_ptr
// ----------------------------------------------------
If (False:C215)
	// ----------------------------------------------------
	//User name (OS): Costas Manousakis
	//User (4D) : Designer
	//Date and time: 04/27/15, 10:30:04
	// ----------------------------------------------------
	//Created : 
	Mods_2015_04
	
	C_TEXT:C284(SVG_GetALLObjects; $1)
	C_POINTER:C301(SVG_GetALLObjects; $2; $3; $4)
	
End if 
//
C_TEXT:C284($1)
C_POINTER:C301($2; $3; $4)

ARRAY TEXT:C222($objrefs_atxt; 0)
ARRAY TEXT:C222($objTypes_atxt; 0)
ARRAY TEXT:C222($objIDS_atxt; 0)

//SVG_ELEMENTS_TO_ARRAYS ($1;->$objrefs_atxt;->$objTypes_atxt;->$objIDS_atxt)
//C_LONGINT($loop_L)
//For ($loop_L;1;Size of array($objrefs_atxt))
//APPEND TO ARRAY($2->;$objrefs_atxt{$loop_L})
//APPEND TO ARRAY($3->;$objTypes_atxt{$loop_L})
//APPEND TO ARRAY($4->;$objIDS_atxt{$loop_L})
//If ($objTypes_atxt{$loop_L}="g")
//SVG_GetALLObjects ($objrefs_atxt{$loop_L};$2;$3;$4)
//End if 
//End for 

//End SVG_GetALLObjects