//%attributes = {"invisible":true}
//Method: INSP_ViewAllComments_WP
//Description
// Display a Write Pro Object 
// Parameters
// $1 : $WPArea_obj
If (False:C215)
	// ----------------------------------------------------
	//User name (OS): Costas Manousakis
	//User (4D) : Designer
	//Date and time: 01/24/21, 21:42:53
	// ----------------------------------------------------
	//Created : 
	Mods_2021_WP
	
	C_OBJECT:C1216(INSP_ViewAllComments_WP; $1)
End if 
//

C_OBJECT:C1216(INSP_Comments_WP)

INSP_Comments_WP:=OB Copy:C1225($1)
C_LONGINT:C283($dispWP)
$dispWP:=Open form window:C675("WPDisplay"; Palette form window:K39:9; On the left:K39:2; At the top:K39:5)
DIALOG:C40("WPDisplay")
CLOSE WINDOW:C154($dispWP)

//End INSP_ViewAllComments_WP