//%attributes = {"invisible":true}
//Method: LSS_StatusColor
//Description
// return the background color based on Status
// Parameters
// ----------------------------------------------------
If (False:C215)
	// ----------------------------------------------------
	//User name (OS): manousakisc
	//User (4D) : Designer
	//Date and time: 04/28/23, 13:47:19
	// ----------------------------------------------------
	//Created : 
	Mods_2023_LSSNew
	
	C_LONGINT:C283(LSS_StatusColor; $0)
End if 
//
C_COLLECTION:C1488(LSS_StatusColors_c; $st_c)
C_TEXT:C284($status_)
If ([LSS_Inventory:165]LSS_Status_s:35="Active") & ([LSS_Inventory:165]LSS_ProjNoRemoved_L:38>0)
	$status_:="Active-to-be-removed"
Else 
	$status_:=[LSS_Inventory:165]LSS_Status_s:35
End if 
$st_c:=LSS_StatusColors_c.query("status = :1"; $status_)
If ($st_c.length=1)
	$0:=$st_c[0].color
Else 
	$0:=-255
End if 

//End LSS_StatusColor