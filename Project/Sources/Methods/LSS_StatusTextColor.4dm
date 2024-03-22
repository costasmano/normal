//%attributes = {"invisible":true}
//Method: LSS_StatusTextColor
//Description
// set the text color for the status field
// Parameters
// ----------------------------------------------------
If (False:C215)
	// ----------------------------------------------------
	//User name (OS): manousakisc
	//User (4D) : Designer
	//Date and time: 05/03/23, 10:33:26
	// ----------------------------------------------------
	//Created : 
	Mods_2023_LSSNew
	C_LONGINT:C283(LSS_StatusTextColor; $0)
	
End if 
//
C_COLLECTION:C1488(LSS_StatusColors_c; $st_c)
$st_c:=LSS_StatusColors_c.query("status = :1"; [LSS_Inventory:165]LSS_Status_s:35)
If ($st_c.length=1)
	$0:=$st_c[0].textcolor
Else 
	//$0:=LSS_StatusColors_c.query("status :1";"default")[0].textcolor
End if 

//End LSS_StatusTextColor