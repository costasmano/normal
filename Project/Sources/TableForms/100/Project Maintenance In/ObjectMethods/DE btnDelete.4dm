If (False:C215)
	// Modified by: costasmanousakis-(Designer)-(12/11/09 12:13:50)
	Mods_2009_12
	//  `Added  better descriptions for the prompt.
End if 

If (Form event code:C388=On Clicked:K2:4)
	CONFIRM:C162("Are you sure you want to delete the Project for Bridge "+vBridgeNo+"?"; "Yes"; "No")
	If (OK=1)
		DELETE RECORD:C58([Contract_Project_Maintenance:100])
		
		//get the list of remaining projects of this assignment
		QUERY:C277([Contract_Project_Maintenance:100]; [Contract_Project_Maintenance:100]ContractNo:2=[Contract_Maintenance:97]ContractNo:1; *)
		QUERY:C277([Contract_Project_Maintenance:100];  & ; [Contract_Project_Maintenance:100]AssignNo:9=[Contract_Assignment_Maintenance:101]AssignNo:2)
		ORDER BY:C49([Contract_Project_Maintenance:100]; [Contract_Project_Maintenance:100]AssignNo:9; >; [Contract_Project_Maintenance:100]BIN:5; >)
		
		If (False:C215)
			If (Not:C34(Is new record:C668([Contract_Project_Maintenance:100])))
				LogDeletion(->[Contracts:79]ContractNo:1; ->[Contract_Project_Maintenance:100]ContractNo:2; ->[Contract_Project_Maintenance:100]ProjectID:1; 1)
			End if 
		End if 
		CANCEL:C270
	End if 
End if 