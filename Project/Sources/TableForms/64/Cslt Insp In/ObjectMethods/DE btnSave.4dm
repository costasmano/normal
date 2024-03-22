If (False:C215)
	//[Cons Inspection];"Cslt Insp In".DE btnSave
	// Modified by: Costas Manousakis-(Designer)-(2024-01-10 18:10:32)
	Mods_2024_01
	//  `added checks for valid contract number and assignment number
	//  `now have to ACCEPT since automatic action was removed from button
	
End if 

If (Form event code:C388=On Clicked:K2:4)
	//start of mods_2024_01
	//Contract and assignment must be a valid. (contract valid and assignment >0)
	
	Case of 
		: ([Cons Inspection:64]ConContractNo:7="")
			ALERT:C41("Error saving record : Contract number has not been defined!")
			
		: (ds:C1482.Contracts.query("ContractNo = :1"; [Cons Inspection:64]ConContractNo:7).length=0)
			ALERT:C41("Error saving record : Contract number ["+[Cons Inspection:64]ConContractNo:7+"] is not an Open Inspection contract!")
		: ([Cons Inspection:64]AssignConNumber:6<=0)
			ALERT:C41("Error saving record : Assignment number cannot be 0!")
			
		: (ds:C1482["Contract Assignments"].query("ContractNo = :1 and AssignNo = :2"; [Cons Inspection:64]ConContractNo:7; [Cons Inspection:64]AssignConNumber:6).length=0)
			ALERT:C41("Error saving record : Assignment number ["+\
				String:C10([Cons Inspection:64]AssignConNumber:6)+"] is not in the list of assignments for contract ["+\
				[Cons Inspection:64]ConContractNo:7+"]!")
			
		Else 
			//end of mods_2024_01
			
			If (Is new record:C668([Cons Inspection:64]))
				LogNewRecord(->[Bridge MHD NBIS:1]BIN:3; ->[Cons Inspection:64]BIN:1; ->[Cons Inspection:64]ConsInspectionID:32; 1; "ConsInsp")
			End if 
			
			//start of mods_2024_01
			ARRAY TEXT:C222($fldstoSkip_atxt; 0)
			APPEND TO ARRAY:C911($fldstoSkip_atxt; "BIN")
			APPEND TO ARRAY:C911($fldstoSkip_atxt; "ConsInspectionID")
			ACT_PushGroupChanges(Table:C252(->[Cons Inspection:64]); 1; ->$fldstoSkip_atxt; True:C214)
			
			FlushGrpChgs(1; ->[Bridge MHD NBIS:1]BIN:3; ->[Cons Inspection:64]BIN:1; ->[Cons Inspection:64]ConsInspectionID:32; 1)
			If (Modified record:C314([Cons Inspection Cost:76]))
				SAVE RECORD:C53([Cons Inspection Cost:76])
			End if 
			
			ACCEPT:C269
			//end of mods_2024_01
			
	End case 
	
End if 