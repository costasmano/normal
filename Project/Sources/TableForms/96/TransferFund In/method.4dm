If (False:C215)
	// Modified by: costasmanousakis-(Designer)-(10/8/08 09:44:12)
	Mods_2008_CM_5404  // ("ACCESS")
End if 

Case of 
	: (Form event code:C388=On Load:K2:1)
		utl_SetSpellandContextMenu
		//InitChangeStack (1)
		If (Is new record:C668([FundTransfer_Maintenance:96]))
			[FundTransfer_Maintenance:96]ContractNo:1:=[Contract_Maintenance:97]ContractNo:1
			Inc_Sequence("FundTransMaint"; ->[FundTransfer_Maintenance:96]TOF_ID:2)
		End if 
		C_BOOLEAN:C305(CM_ViewOnly_b)
		If (CM_ViewOnly_b)
			OBJECT SET ENTERABLE:C238(*; "@"; False:C215)
			OBJECT SET ENABLED:C1123(*; "DE@"; False:C215)  // Command Replaced was o_DISABLE BUTTON 
			OBJECT SET ENABLED:C1123(cboDirection; False:C215)  // Command Replaced was o_DISABLE BUTTON 
			OBJECT SET ENABLED:C1123(Button1; False:C215)  // Command Replaced was o_DISABLE BUTTON 
		End if 
		
	: (Form event code:C388=On Validate:K2:3)
		If (False:C215)
			FlushGrpChgs(1; ->[Contract_Maintenance:97]ContractNo:1; ->[FundTransfer_Maintenance:96]ContractNo:1; ->[FundTransfer_Maintenance:96]TOF_ID:2; 1)
		End if 
End case 