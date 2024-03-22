//Method: Object Method: [LSS_Inventory].Edit_SIN.LSS_SIN_2_L
//Description
//
// Parameters
// ----------------------------------------------------
If (False:C215)
	// ----------------------------------------------------
	//User name (OS): Costas Manousakis
	//User (4D) : Designer
	//Date and time: 09/03/15, 11:08:15
	// ----------------------------------------------------
	//Created : 
	Mods_2015_09_bug
End if 
//
Case of 
	: (Form event code:C388=On Load:K2:1)
		
	: (Form event code:C388=On After Keystroke:K2:26)
		OBJECT SET ENABLED:C1123(*; "ApplyButton"; False:C215)  // Command Replaced was o_DISABLE BUTTON 
	: (Form event code:C388=On After Edit:K2:43) | (Form event code:C388=On Data Change:K2:15)
		v_165_005_l:=[LSS_Inventory:165]LSS_District_L:3*100000+LSS_SIN_2_L
		v_165_006_txt:=Substring:C12(v_165_006_txt; 1; Length:C16(v_165_006_txt)-6)
		v_165_006_txt:=v_165_006_txt+String:C10(v_165_005_l)
		
End case 

//End Object Method: [LSS_Inventory].Edit_SIN.LSS_SIN_2_L