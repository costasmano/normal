If (False:C215)
	// Modified by: costasmanousakis-(Designer)-(2/21/2006 15:34:57)
	Mods_2006_CM03
	// Modified by: Costas Manousakis-(Designer)-(2024-01-16 17:31:09)
	Mods_2024_01
	//  `update any related cons insp or cons rating records
End if 

If (Form event code:C388=On Clicked:K2:4)
	
	//check for unique assignment number before saving it
	
	C_LONGINT:C283($vlRecCount)
	SET QUERY DESTINATION:C396(Into variable:K19:4; $vlRecCount)
	
	QUERY:C277([Contract Assignments:83]; [Contract Assignments:83]ContractNo:1=[Contracts:79]ContractNo:1; *)
	QUERY:C277([Contract Assignments:83];  & ; [Contract Assignments:83]AssignNo:2=[Contract Assignments:83]AssignNo:2)
	SET QUERY DESTINATION:C396(Into current selection:K19:1)
	
	If (($vlRecCount>0) & (Is new record:C668([Contract Assignments:83])))
		ALERT:C41("This assignment number is already being used. Please enter a different one!")
	Else 
		//start of Mods_2024_01
		//update any changes of rates, RFP, NTP written , verbal to Cons Insp or Cons Rtg records
		// need to do this before saving record so we can check if any of the required fields changed
		CIR_UpdateAssgnFields
		//end of Mods_2024_01
		
		SAVE RECORD:C53([Contract Assignments:83])
		
		//update approx and actual spent in [Contracts]  
		CIR_RecalcAssgnFunds(True:C214)  //update/Save Contracts record
		
		CANCEL:C270
	End if 
	
End if 