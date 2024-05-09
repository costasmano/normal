//%attributes = {}
//Method: LSS_ManageAncInspContracts
//Description
// open LSS_EditContracts dialog to manage Anc Structure inspection contracts
// ----------------------------------------------------
If (False:C215)
	// ----------------------------------------------------
	//User name (OS): Costas Manousakis
	//User (4D) : Designer
	//Created : 
	//Date and time: Mar 1, 2024, 14:19:00
	Mods_2024_LSS_1
	// ----------------------------------------------------
	
End if 
//
C_LONGINT:C283($left_; $top_; $right_; $bot_; $fw; $fl; $wx; $Win_L)
GET WINDOW RECT:C443($left_; $top_; $right_; $bot_)
FORM GET PROPERTIES:C674("LSS_EditContracts"; $fw; $fl)
//place window at top of current window centered.
$wx:=(($right_+$left_)/2)-($fw/2)

$Win_L:=Open form window:C675("LSS_EditContracts"; Plain form window:K39:10+Form has no menu bar:K39:18; $wx; $top_)
DIALOG:C40("LSS_EditContracts")
CLOSE WINDOW:C154($Win_L)
//End LSS_ManageAncInspContracts   