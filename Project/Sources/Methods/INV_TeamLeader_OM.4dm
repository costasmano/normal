//%attributes = {"invisible":true}
// Method: INV_TeamLeader_OM
// Description
// object method for TL drop down in inventory inspections
// 
// Parameters
If (False:C215)
	// ----------------------------------------------------
	// User name (OS): costasmanousakis
	// User name (4D): Designer
	// Date and time: 11/10/06, 22:41:56
	// ----------------------------------------------------
	Mods_2007_CM02
	// Modified by: Costas Manousakis-(Designer)-(6/30/21 17:49:54)
	Mods_2021_06
	//  `fix code to handle cases when team leaders are inactve
End if 
REDRAW:C174(aTeamLeader)
POPUPMENUC(->aTeamLeader; ->aTeamLdrID; ->[InventoryPhotoInsp:112]TeamLeader_I:5)
If (Form event code:C388=On Clicked:K2:4)
	LogLink(->[InventoryPhotoInsp:112]TeamLeader_I:5; ->[Bridge MHD NBIS:1]BIN:3; ->[InventoryPhotoInsp:112]BIN:2; ->[InventoryPhotoInsp:112]InvPhotoInspID_L:1; 1; ->[Personnel:42]Person ID:1)
End if 
If (aTeamLeader>0)
	vTmLeader:=aTeamLeader{aTeamLeader}
Else 
	
	If ([InventoryPhotoInsp:112]TeamLeader_I:5>0)
		C_LONGINT:C283($i)
		$i:=Find in array:C230(apeople_id; [InventoryPhotoInsp:112]TeamLeader_I:5)
		If ($i>0)
			vTmLeader:=apeople{$i}
		Else 
			vTmLeader:="Unknown TL (ID:"+String:C10([InventoryPhotoInsp:112]TeamLeader_I:5)+")"
		End if 
	Else 
		vTmLeader:="Choose Team Leader"
	End if 
End if 