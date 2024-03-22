
//----------------------------------------------------
//User name (OS): administrator
//Date and time: 01/07/16, 15:01:21
//----------------------------------------------------
//Method: Object Method: [LSS_Inventory].Edit_SIN.v_165_008_r
//Description
//
// Parameters
// ----------------------------------------------------
If (False:C215)
	Mods_2016_01_bug  // Add item that user can change in Structure number
	//Modified by: administrator (1/7/16 14:53:31)
End if 
Case of 
	: (Form event code:C388=On Data Change:K2:15)
		If (v_165_008_r#0)
			[LSS_Inventory:165]LSS_MilePoint_r:8:=v_165_008_r
			[LSS_Inventory:165]LSS_KiloPoint_r:7:=Round:C94([LSS_Inventory:165]LSS_MilePoint_r:8/0.621371; 2)
			v_165_007_r:=[LSS_Inventory:165]LSS_KiloPoint_r:7
			C_LONGINT:C283($MilePost_L)
			$MilePost_L:=Trunc:C95([LSS_Inventory:165]LSS_MilePoint_r:8; 0)
			v_165_006_txt:=LSS_UpdateStructNumPart(v_165_006_txt; String:C10($MilePost_L; "000"); 4)
			OBJECT SET ENABLED:C1123(*; "ApplyButton"; False:C215)  // Command Replaced was o_DISABLE BUTTON 
			
		Else 
			[LSS_Inventory:165]LSS_MilePoint_r:8:=Old:C35([LSS_Inventory:165]LSS_MilePoint_r:8)
			ALERT:C41("You can not change Mile Point to 0")
		End if 
	: (Form event code:C388=On After Keystroke:K2:26)
		OBJECT SET ENABLED:C1123(*; "ApplyButton"; False:C215)  // Command Replaced was o_DISABLE BUTTON 
End case 
//End Object Method: [LSS_Inventory].Edit_SIN.v_165_008_r

