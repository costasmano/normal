//%attributes = {"invisible":true,"publishedSql":true}

//----------------------------------------------------
//User name (OS): Charles Miller
//Date and time: 08/19/11, 12:06:43
//----------------------------------------------------
//Method: ut_ReturnStructureName
//Description
//
// Parameters
// ----------------------------------------------------
If (False:C215)
	//Ugrade to v11
	//Modified by: Charles Miller (8/19/11 12:06:44)
	// Modified by: Costas Manousakis-(Designer)-(9/25/13 14:34:43)
	Mods_2013_09
	//  `Make sure there is directories in the structure file 
End if 
C_TEXT:C284($0)

If (Position:C15(<>PL_DirectorySep_s; Structure file:C489)>0)
	$0:=Replace string:C233(Structure file:C489; GetPath(Structure file:C489); "")
Else 
	$0:=Structure file:C489
End if 

//End ut_ReturnStructureName