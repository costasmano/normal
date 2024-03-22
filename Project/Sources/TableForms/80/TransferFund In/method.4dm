If (False:C215)
	//declare pulldown array for compilation
	ARRAY TEXT:C222(cboDirection; 0)
	
	Mods_2004_CM12
	If (False:C215)
		// Modified by: costasmanousakis-(Designer)-(10/7/08 12:58:31)
		Mods_2008_CM_5404  // ("ACCESS")
	End if 
	
	// Modified by: Costas Manousakis-(Designer)-(6/4/20 18:11:19)
	Mods_2020_06
	//  `added button to generate a letter for transfer of funds CallRefernece #699
End if 

Case of 
	: (Form event code:C388=On Load:K2:1)
		utl_SetSpellandContextMenu
		InitChangeStack(1)
		If (Is new record:C668([Contract FundTransfer:80]))
			[Contract FundTransfer:80]ContractNo:1:=[Contracts:79]ContractNo:1
			Inc_Sequence("FundTransfer"; ->[Contract FundTransfer:80]TOF_ID:2)
		End if 
		C_BOOLEAN:C305(InspRtgContrAccess_b)
		If (InspRtgContrAccess_b)
			OBJECT SET ENABLED:C1123(*; "DE@"; False:C215)  // Command Replaced was o_DISABLE BUTTON 
			OBJECT SET ENTERABLE:C238(*; "@"; False:C215)
		End if 
		
	: (Form event code:C388=On Validate:K2:3)
		If (False:C215)
			FlushGrpChgs(1; ->[Contracts:79]ContractNo:1; ->[Contract FundTransfer:80]ContractNo:1; ->[Contract FundTransfer:80]TOF_ID:2; 1)
		End if 
End case 