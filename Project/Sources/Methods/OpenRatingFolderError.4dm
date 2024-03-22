//%attributes = {"invisible":true}
//Method: OpenRatingFolderError
//Description
//
// Parameters
// ----------------------------------------------------
If (False:C215)
	// ----------------------------------------------------
	//User name (OS): Chuck
	//User (4D) : Designer
	//Date and time: 05/05/20, 16:23:11
	// ----------------------------------------------------
	//Created : 
	
	Mods_2020_05  //Add to make sure rating folders can be created
	//Modified by: Chuck (5/5/20 16:23:38)
End if 
//
ARRAY LONGINT:C221(SQLErrorNumbers_al; 0)
ARRAY TEXT:C222(SQL_InternalCodes_atxt; 0)
ARRAY TEXT:C222(SQL_InternalDescriptions_atxt; 0)
GET LAST ERROR STACK:C1015(SQLErrorNumbers_al; SQL_InternalCodes_atxt; SQL_InternalDescriptions_atxt)
4DError_b:=True:C214
//End OpenRatingFolderError