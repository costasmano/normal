If (False:C215)
	//Form Method:[Contract_Project_Maintenance];"Project Maintenance In" 
	// Modified by: costasmanousakis-(Designer)-(11/21/07 12:16:09)
	Mods_2007_CM_5401
	// Modified by: costasmanousakis-(Designer)-(10/7/08 16:44:54)
	Mods_2008_CM_5404  // ("ACCESS")
End if 

Case of 
	: (Form event code:C388=On Load:K2:1)
		utl_SetSpellandContextMenu
		
		If (Is new record:C668([Contract_Project_Maintenance:100]))
			If ([Contract_Assignment_Maintenance:101]AssignID:3=0)
				CANCEL:C270
			Else 
				Inc_Sequence("ProjMaint"; ->[Contract_Project_Maintenance:100]ProjectID:1)
				
				//initialize all variables
				[Contract_Project_Maintenance:100]ContractNo:2:=[Contract_Maintenance:97]ContractNo:1
				[Contract_Project_Maintenance:100]AssignNo:9:=[Contract_Assignment_Maintenance:101]AssignNo:2
				[Contract_Project_Maintenance:100]AssignID:13:=[Contract_Assignment_Maintenance:101]AssignID:3
				[Contract_Project_Maintenance:100]Project Type:3:=""
				[Contract_Project_Maintenance:100]BIN:5:=""
				vBridgeNo:=""
				vDistrict:=""
				vTown:=""
				vLocation:=""
			End if 
		Else 
			vBridgeNo:=[Contract_Project_Maintenance:100]BridgeNo:4
			vDistrict:=[Contract_Project_Maintenance:100]District:8
			vTown:=[Contract_Project_Maintenance:100]Town:7
			vLocation:=[Contract_Project_Maintenance:100]Location:6
		End if 
		C_BOOLEAN:C305(CM_ViewOnly_b)
		If (CM_ViewOnly_b)
			OBJECT SET ENTERABLE:C238(*; "@"; False:C215)
			OBJECT SET ENABLED:C1123(*; "DE@"; False:C215)  // Command Replaced was o_DISABLE BUTTON 
			OBJECT SET ENABLED:C1123(asItemsOfSubList; False:C215)  // Command Replaced was o_DISABLE BUTTON 
		End if 
		
End case 