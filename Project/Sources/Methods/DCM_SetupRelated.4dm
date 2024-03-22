//%attributes = {"invisible":true}
If (False:C215)
	// ----------------------------------------------------
	// User name (OS): costasmanousakis
	// User name (4D): Designer
	// Date and time: 08/25/09, 10:33:59
	// ----------------------------------------------------
	// Method: DCM_SetupRelated
	// Description
	// 
	// 
	// Parameters
	// ----------------------------------------------------
	
	Mods_2010_05
End if 
C_LONGINT:C283($1; $PageNo)  //Command Replaced was o_C_INTEGER
$PageNo:=$1
Case of 
	: ($PageNo=1)
	: ($PageNo=2)  //
		QUERY:C277([DCM_WorkOrders:137]; [DCM_WorkOrders:137]ContractNo:1=[DCM_Contracts:136]ContractNo:1)
		ORDER BY:C49([DCM_WorkOrders:137]; [DCM_WorkOrders:137]AssignNo:2; <)
	: ($PageNo=3)
		DCM_SetupRelated(2)
		If (Records in selection:C76([DCM_WorkOrders:137])>0)
			//RELATE MANY SELECTION([DCM_WorkOrders]AssignID)
			ARRAY LONGINT:C221($TempIDs_aL; Records in selection:C76([DCM_WorkOrders:137]))
			SELECTION TO ARRAY:C260([DCM_WorkOrders:137]AssignID:3; $TempIDs_aL)
			QUERY WITH ARRAY:C644([DCM_Project:138]AssignID:13; $TempIDs_aL)
			//QUERY([DCM_Project];[DCM_Project]AssignID=[DCM_WorkOrders]AssignID)
			ORDER BY:C49([DCM_Project:138]; [DCM_Project:138]AssignNo:9; >; [DCM_Project:138]BIN:5; >)
		Else 
			REDUCE SELECTION:C351([DCM_Project:138]; 0)
		End if 
	: ($PageNo=-1)
		DCM_SetupRelated(3)  //3 does 2 and 3
		//DCM_SetupRelated (4)
		//DCM_SetupRelated (5)
		//DCM_SetupRelated (6)
		
End case 
