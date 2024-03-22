If (Form event code:C388=On Clicked:K2:4)
	
	If (False:C215)
		If (Is new record:C668([Addendum_Maintenance:102]))
			LogNewRecord(->[Contract_Maintenance:97]ContractNo:1; ->[Addendum_Maintenance:102]ContractNo:5; ->[Addendum_Maintenance:102]AddendumID:1; 1; "AddendumMaint")
		End if 
	End if 
	
	//check for unique addendum number before saving it
	
	C_LONGINT:C283($vlRecCount)
	SET QUERY DESTINATION:C396(Into variable:K19:4; $vlRecCount)
	
	QUERY:C277([Addendum_Maintenance:102]; [Addendum_Maintenance:102]ContractNo:5=[Contract_Maintenance:97]ContractNo:1; *)
	QUERY:C277([Addendum_Maintenance:102];  & ; [Addendum_Maintenance:102]AssignNo:4=[Contract_Assignment_Maintenance:101]AssignNo:2; *)
	QUERY:C277([Addendum_Maintenance:102];  & ; [Addendum_Maintenance:102]AddendumNo:2=[Addendum_Maintenance:102]AddendumNo:2)
	
	SET QUERY DESTINATION:C396(Into current selection:K19:1)
	
	If (($vlRecCount>0) & (Is new record:C668([Addendum_Maintenance:102])))
		ALERT:C41("This addendum number is already being used. Please enter a different one!")
	Else 
		SAVE RECORD:C53([Addendum_Maintenance:102])
		
		CM_CalculateNegotiatedCosts
		SAVE RECORD:C53([Contract_Assignment_Maintenance:101])
		CANCEL:C270
	End if 
End if 


