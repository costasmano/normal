//%attributes = {"invisible":true}
//Method: LSS_SetUpP2Recommendation
//Description
//
// Parameters
// ----------------------------------------------------
If (False:C215)
	// ----------------------------------------------------
	//User name (OS): Chuck Miller
	//User (4D) : Designer
	//Date and time: 11/01/18, 11:29:43
	// ----------------------------------------------------
	//Created : 
	Mods_2018_11
End if 
//
C_BOOLEAN:C305($Visible_B)
C_LONGINT:C283($Pos_L)
$Pos_L:=Position:C15("Damage"; v_167_002_txt)
$Visible_B:=$Pos_L<1
OBJECT SET VISIBLE:C603(*; "LSS_Recommendation@"; $Visible_B)

//End LSS_SetUpP2Recommendation