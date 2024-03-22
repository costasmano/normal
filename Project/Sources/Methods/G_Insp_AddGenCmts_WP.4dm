//%attributes = {"invisible":true}
//Method: G_Insp_AddGenCmts_WP
//Description
//
// Parameters
// $1 : $WPArea
// ----------------------------------------------------
If (False:C215)
	// ----------------------------------------------------
	//User name (OS): Costas Manousakis
	//User (4D) : Designer
	//Date and time: 01/24/21, 18:00:05
	// ----------------------------------------------------
	//Created : 
	Mods_2021_WP
	
	C_OBJECT:C1216(G_Insp_AddGenCmts_WP; $1)
End if 
//

C_OBJECT:C1216($1)

G_AddElmtTxt2Area_WP($1; "GENERAL REMARKS"; [Inspections:27]InspComments:171)

//End G_Insp_AddGenCmts_WP