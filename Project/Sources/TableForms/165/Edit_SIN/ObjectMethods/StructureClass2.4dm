
//----------------------------------------------------
//User name (OS): administrator
//Date and time: 01/07/16, 15:50:56
//----------------------------------------------------
//Method: Object Method: [LSS_Inventory].Edit_SIN.LSS_StructureClass_atxt
//Description
//
// Parameters
// ----------------------------------------------------
If (False:C215)
	Mods_2016_01_bug  // Add item that user can change in Structure number
	//Modified by: administrator (1/7/16 14:53:31)
	// Modified by: Costas Manousakis-(Designer)-(9/6/16 10:26:37)
	Mods_2016_09
	//  `changed label for Inventory Number HS -HIN, SI - SIN
End if 
Case of 
	: (Form event code:C388=On Clicked:K2:4)
		If (LSS_StructureClass_atxt>1)
			[LSS_Inventory:165]LSS_InventoryType_s:28:=Replace string:C233(Choose:C955(LSS_StructureClass_atxt; (20*" "); ""; "HS"; "LI"; "SI"; "IT"); " "; "")
			[LSS_Inventory:165]LSS_Category_s:2:=Replace string:C233(Choose:C955(LSS_StructureClass_atxt; 20*(" "); ""; "Sign"; "Light"; "Signal"; "ITS"); " "; "")
			LSS_SIN_Label_txt:=Replace string:C233(Choose:C955(LSS_StructureClass_atxt; 20*(" "); ""; "HIN"; "LIN"; "SIN"; "IIN"); " "; "")
			If (False:C215)
				C_TEXT:C284($SaveSIN_txt)
				$SaveSIN_txt:=[LSS_Inventory:165]LSS_StructureNumber_s:6
				LSS_SetInventoryNumber
				v_165_006_txt:=[LSS_Inventory:165]LSS_StructureNumber_s:6
				[LSS_Inventory:165]LSS_StructureNumber_s:6:=$SaveSIN_txt
				
			End if 
			v_165_006_txt:=LSS_UpdateStructNumPart(v_165_006_txt; [LSS_Inventory:165]LSS_InventoryType_s:28; 2)
			OBJECT SET ENABLED:C1123(*; "ApplyButton"; False:C215)  // Command Replaced was o_DISABLE BUTTON 
		End if 
End case 

//End Object Method: [LSS_Inventory].Edit_SIN.LSS_StructureClass_atxt

