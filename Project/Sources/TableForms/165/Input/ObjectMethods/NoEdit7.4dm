
//----------------------------------------------------
//User name (OS): administrator
//Date and time: 08/13/15, 12:09:32
//----------------------------------------------------
//Method: Object Method: [LSS_Inventory].Input.LSS_MilePoint_r
//Description
//
// Parameters
// ----------------------------------------------------
If (False:C215)
	Mods_2015_08_bug
	// Added code to allow change to mile marker/ kilo point on 
	//Modified by: administrator (8/13/15 12:16:35)
End if 
If ([LSS_Inventory:165]LSS_MilePoint_r:8#0)
	[LSS_Inventory:165]LSS_KiloPoint_r:7:=Round:C94([LSS_Inventory:165]LSS_MilePoint_r:8/0.621371; 2)
	[LSS_Inventory:165]LSS_StructureNumber_s:6:=LSS_ResetStructureNumber
	OBJECT SET ENABLED:C1123(bValidate; True:C214)  // Command Replaced was o_ENABLE BUTTON 
Else 
	[LSS_Inventory:165]LSS_MilePoint_r:8:=Old:C35([LSS_Inventory:165]LSS_MilePoint_r:8)
	ALERT:C41("You can not change Mile Point to 0")
	OBJECT SET ENABLED:C1123(bValidate; False:C215)  // Command Replaced was o_DISABLE BUTTON 
End if 

//End Object Method: [LSS_Inventory].Input.LSS_MilePoint_r

