//Method: [LSS_Inventory].Edit_SIN.VerifyButton
//Description
//
// Parameters
// ----------------------------------------------------
If (False:C215)
	// ----------------------------------------------------
	//User name (OS): Costas Manousakis
	//User (4D) : Designer
	//Date and time: 09/02/15, 17:42:53
	// ----------------------------------------------------
	//Created : 
	Mods_2015_09_bug
End if 
//
Case of 
	: ([LSS_Inventory:165]LSS_Category_s:2="")
	: ([LSS_Inventory:165]LSS_InventoryType_s:28="")
	: ([LSS_Inventory:165]LSS_KiloPoint_r:7<=0)
	: ([LSS_Inventory:165]LSS_MilePoint_r:8<=0)
	: ([LSS_Inventory:165]LSS_Route_s:9="")
	: ([LSS_Inventory:165]LSS_RouteDirection_s:14="")
		
	Else 
		C_LONGINT:C283($MaxNumber_L; $Count_L)
		$Count_L:=LSS_VerifyNewInventoryNumber(->$MaxNumber_L)
		If ($Count_L>0)
			C_TEXT:C284($msg_txt)
			$msg_txt:="Another structure of type "+[LSS_Inventory:165]LSS_InventoryType_s:28+" exists on Route "+Substring:C12([LSS_Inventory:165]LSS_Route_s:9; 1; 5)+" in District "+String:C10([LSS_Inventory:165]LSS_District_L:3)
			$msg_txt:=$msg_txt+" with "+LSS_SIN_Label_txt+String:C10($MaxNumber_L; " ######")+" !!!"+<>sCR+"Value has been reset."
			LSS_SIN_2_L:=Num:C11(Substring:C12(String:C10([LSS_Inventory:165]LSS_IdentificationNumber_L:5); 2))
			GOTO OBJECT:C206(*; "LSS_SIN_2_L")
			POST KEY:C465(Tab key:K12:28)
			POST KEY:C465(Tab key:K12:28; Shift key mask:K16:3)
			OBJECT SET ENABLED:C1123(*; "ApplyButton"; False:C215)  // Command Replaced was o_DISABLE BUTTON 
			ALERT:C41($msg_txt)
		Else 
			v_165_005_l:=[LSS_Inventory:165]LSS_District_L:3*100000+LSS_SIN_2_L
			v_165_006_txt:=Substring:C12(v_165_006_txt; 1; Length:C16(v_165_006_txt)-6)
			v_165_006_txt:=v_165_006_txt+String:C10(v_165_005_l)
			OBJECT SET ENABLED:C1123(*; "ApplyButton"; True:C214)  // Command Replaced was o_ENABLE BUTTON 
		End if 
		
End case 

//End [LSS_Inventory].Edit_SIN.VerifyButton