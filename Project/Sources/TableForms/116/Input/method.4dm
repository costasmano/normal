//Method: Form Method: [PRJ_ConstructionProject];"Input"
//Description
//
// Parameters
// ----------------------------------------------------
If (False:C215)
	// ----------------------------------------------------
	//User name (OS): Costas Manousakis
	//User (4D) : Designer
	//Date and time: 04/23/15, 11:40:01
	// ----------------------------------------------------
	//Created : 
	Mods_2015_04
	//added the listbox with the bid items
End if 
//

Case of 
	: (Form event code:C388=On Load:K2:1)
		C_BLOB:C604($SQLArrays_x)
		C_LONGINT:C283($offset_L)
		$offset_L:=0
		If (BLOB size:C605([PRJ_ConstructionProject:116]CP_AEData_blb:21)>0)
			BLOB TO VARIABLE:C533([PRJ_ConstructionProject:116]CP_AEData_blb:21; $SQLArrays_x; $offset_L)
			
			$offset_L:=0
			BLOB TO VARIABLE:C533($SQLArrays_x; ITMLB_AE_ItemNos_as; $offset_L)
			BLOB TO VARIABLE:C533($SQLArrays_x; ITMLB_AE_ItemUnit_as; $offset_L)
			BLOB TO VARIABLE:C533($SQLArrays_x; ITMLB_AE_ItemDesc_atxt; $offset_L)
			BLOB TO VARIABLE:C533($SQLArrays_x; ITMLB_AE_ItemQ_ar; $offset_L)
			BLOB TO VARIABLE:C533($SQLArrays_x; ITMLB_AE_ItemPrice_ar; $offset_L)
			
			SET BLOB SIZE:C606($SQLArrays_x; 0)
			
		Else 
			ARRAY REAL:C219(ITMLB_AE_ItemPrice_ar; 0)
			ARRAY REAL:C219(ITMLB_AE_ItemQ_ar; 0)
			ARRAY TEXT:C222(ITMLB_AE_ItemDesc_atxt; 0)
			ARRAY TEXT:C222(ITMLB_AE_ItemUnit_as; 0)  //Command Replaced was o_ARRAY string length was 3
			ARRAY TEXT:C222(ITMLB_AE_ItemNos_as; 0)  //Command Replaced was o_ARRAY string length was 7
		End if 
		
	: (Form event code:C388=On Validate:K2:3)
		CANCEL:C270
End case 

//End Form Method: [PRJ_ConstructionProject]Input