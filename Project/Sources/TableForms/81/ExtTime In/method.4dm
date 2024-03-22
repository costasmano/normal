If (False:C215)
	// Modified by: costasmanousakis-(Designer)-(10/7/08 12:58:31)
	Mods_2008_CM_5404  // ("ACCESS")
End if 

Case of 
	: (Form event code:C388=On Load:K2:1)
		utl_SetSpellandContextMenu
		InitChangeStack(1)
		If (Is new record:C668([Contract ExtendTime:81]))
			[Contract ExtendTime:81]ContractNo:1:=[Contracts:79]ContractNo:1
			Inc_Sequence("ExtTime"; ->[Contract ExtendTime:81]EOT_ID:2)
			
			//set the default value of Initial Date = date from Contracts table    
			If ([Contracts:79]ExtendedCompleteDate:6=!00-00-00!)
				[Contract ExtendTime:81]InitialDate:6:=[Contracts:79]InitialCompleteDate:5
			Else 
				[Contract ExtendTime:81]InitialDate:6:=[Contracts:79]ExtendedCompleteDate:6
			End if 
			
		End if 
		C_BOOLEAN:C305(InspRtgContrAccess_b)
		If (InspRtgContrAccess_b)
			OBJECT SET ENABLED:C1123(*; "DE@"; False:C215)  // Command Replaced was o_DISABLE BUTTON 
			OBJECT SET ENTERABLE:C238(*; "@"; False:C215)
		End if 
		
		
	: (Form event code:C388=On Validate:K2:3)
		If (False:C215)
			FlushGrpChgs(1; ->[Contracts:79]ContractNo:1; ->[Contract ExtendTime:81]ContractNo:1; ->[Contract ExtendTime:81]EOT_ID:2; 1)
		End if 
		
End case 