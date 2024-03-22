//%attributes = {"invisible":true}
If (False:C215)
	//M_SearchbyContractNo
	//4/22/2004: Modified from M_SearchBridge
	//depending on the passed parameters, it displays a search dialog box
	//that lets users search Conslt Rating or Conslt Insp by Contract No and Assign No
	
	// Modified by: Costas Manousakis-(Designer)-(3/2/20 17:00:26)
	Mods_2020_03_bug
	//  `set window type to Movable dialog box - use new method Center_Window_2 to center on current window
End if 
C_TEXT:C284($1)  // **Replaced old C_STRING length 20
If ($1="Conslt Rating")
	Center_Window_2(330; 200; Movable dialog box:K34:7)
	DIALOG:C40([Dialogs:21]; "Search by ContractNo in CR")
	CLOSE WINDOW:C154
	COPY NAMED SELECTION:C331([Conslt Rating:63]; "Temp")
Else 
	Center_Window_2(330; 200; Movable dialog box:K34:7)
	DIALOG:C40([Dialogs:21]; "Search by ContractNo in CI")
	CLOSE WINDOW:C154
	COPY NAMED SELECTION:C331([Cons Inspection:64]; "Temp")
End if 

If (Ok=1)
	If (Records in set:C195("Random Set")=0)
		If ((vContractNo#"") | (vsAssignNo#""))
			If ($1="Conslt Rating")
				CreateRandomSetinCR_Contract
			Else 
				CreateRandomSetinCI_Contract
			End if 
			USE SET:C118("Random Set")
		End if 
	Else 
		USE SET:C118("Random Set")
	End if 
Else 
	USE NAMED SELECTION:C332("Temp")
End if 
CLEAR NAMED SELECTION:C333("Temp")
CLEAR SET:C117("Random Set")
RegionTitle