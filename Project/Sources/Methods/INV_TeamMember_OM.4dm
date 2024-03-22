//%attributes = {"invisible":true}
// Method: INV_TeamMember_OM
// Description
// Object method for TM drop down in inventory inspections
// 
// Parameters
If (False:C215)
	// ----------------------------------------------------
	// User name (OS): costasmanousakis
	// User name (4D): Designer
	// Date and time: 11/13/06, 12:05:18
	Mods_2007_CM02
	// Modified by: Costas Manousakis-(Designer)-(6/30/21 17:49:46)
	Mods_2021_06
	//  `fix code to handle cases when team members are inactve
End if 
REDRAW:C174(aTeamMbr)
C_TEXT:C284(vTmMember)
POPUPMENUC(->aTeamMbr; ->aTeamMbrID; ->[InventoryPhotoInsp:112]TeamMember_I:10)
If (Form event code:C388=On Clicked:K2:4)
	LogLink(->[InventoryPhotoInsp:112]TeamMember_I:10; ->[Bridge MHD NBIS:1]BIN:3; ->[InventoryPhotoInsp:112]BIN:2; ->[InventoryPhotoInsp:112]InvPhotoInspID_L:1; 1; ->[Personnel:42]Person ID:1)
End if 
If (aTeamMbr>0)
	vTmMember:=aTeamMbr{aTeamMbr}
Else 
	
	If ([InventoryPhotoInsp:112]TeamMember_I:10>0)
		C_LONGINT:C283($i)
		$i:=Find in array:C230(apeople_id; [InventoryPhotoInsp:112]TeamMember_I:10)
		If ($i>0)
			vTmMember:=apeople{$i}
		Else 
			vTmMember:="Unknown TM (ID:"+String:C10([InventoryPhotoInsp:112]TeamMember_I:10)+")"
		End if 
	Else 
		vTmMember:="Choose Team Member"
	End if 
	
End if 
