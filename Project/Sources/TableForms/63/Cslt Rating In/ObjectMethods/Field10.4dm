//added 01/13/04 - tying with Contracts table
READ ONLY:C145([Contracts:79])
QUERY:C277([Contracts:79]; [Contracts:79]ContractNo:1=[Conslt Rating:63]ContractNoRat:14)
//FIRST RECORD([Contracts])
//perform checking
If (Records in selection:C76([Contracts:79])>0)
	If (Uppercase:C13([Contracts:79]ContractStatus:7)="CLOSED")
		ALERT:C41("The status of this contract number is CLOSED.")
	Else 
		
		C_TEXT:C284($type)  // Command Replaced was o_C_STRING length was 20
		$type:=Substring:C12([Contracts:79]ContractType:2; Position:C15(" "; [Contracts:79]ContractType:2)+1; Length:C16([Contracts:79]ContractType:2))
		If ($type="Inspection")
			ALERT:C41("This contract number is for INSPECTIONS only!")
		Else 
			[Conslt Rating:63]ContractType:48:=Substring:C12([Contracts:79]ContractType:2; 1; Position:C15(" "; [Contracts:79]ContractType:2)-1)
			PushChange(1; ->[Conslt Rating:63]ContractType:48)
			POPUPMENUC(->cboContractType; ->cboContractType; ->[Conslt Rating:63]ContractType:48)
			
			[Conslt Rating:63]AssignRatCons:5:=[Contracts:79]ConsltName:3
			PushChange(1; ->[Conslt Rating:63]AssignRatCons:5)
			[Conslt Rating Cost:74]OverheadRate:40:=[Contracts:79]OverheadRate:10
			//````````````````````````````````````````````````````````````````````````````````
			//````````````````````````````````````````````````````````````````````````````````
			//`[Conslt Rating Cost]NetFeeRate is specified as "delete me" and invisible
			netFeeRate:=[Contracts:79]NetFeeRate:11
			overheadRate:=[Contracts:79]OverheadRate:10
			//````````````````````````````````````````````````````````````````````````````````
			//````````````````````````````````````````````````````````````````````````````````
		End if 
	End if 
Else 
	ALERT:C41("The contract number is not found in Contracts!  Please define it first.")
	
End if 

PushChange(1; Self:C308)