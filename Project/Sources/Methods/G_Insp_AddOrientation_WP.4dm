//%attributes = {"invisible":true}
//Method: G_Insp_AddOrientation_WP
//Description
//
// Parameters
// $1 : $WPArea
// ----------------------------------------------------
If (False:C215)
	// ----------------------------------------------------
	//User name (OS): Costas Manousakis
	//User (4D) : Designer
	//Date and time: 01/24/21, 17:57:37
	// ----------------------------------------------------
	//Created : 
	Mods_2021_WP
	
	C_OBJECT:C1216(G_Insp_AddOrientation_WP; $1)
End if 
//

C_OBJECT:C1216($1)

C_TEXT:C284($Title_txt)

Case of 
	: ([Inspections:27]Insp Type:6="T@")
		$Title_txt:="TUNNEL ORIENTATION"
	Else 
		$Title_txt:="BRIDGE ORIENTATION"
End case 

G_AddElmtTxt2Area_WP($1; $Title_txt; [Inspections:27]OrientationText:204)

//End G_Insp_AddOrientation_WP